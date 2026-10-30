extends Node2D
class_name BaseSurvivor

@export var Name: String
@export var BaseHp: float = 100.0
@export var BasePower: float = 100.0


@export var FlashLight: PackedScene
@export var Loadout: Dictionary = {
	"1": "Flashlight",
	"2": "Camera",
	"3": "Interact",
}

@onready var HandAnchor: Marker2D = $Anchor
@onready var Hand: AnimatedSprite2D = $Hand

var Game: Node2D
var Light: Node2D
var FlashlightActive: bool = false
var CurrSlot: int = 1

func _ready():
	Game = get_tree().get_first_node_in_group("Game")
	Hand.global_position = HandAnchor.global_position
	LoadLight()

func LoadLight():
	Light = FlashLight.instantiate()
	Light.Hand = Hand
	Light.visible = false
	Hand.add_child(Light)

func _process(_d: float):
	CheckMouse()
	CheckHand()
	CheckLight()

func _input(_e: InputEvent):
	if CurrSlot == 2:
		if Input.is_action_pressed("Flashlight"):
			FlashlightActive = true
		else:
			FlashlightActive = false
	
	if Input.is_action_just_pressed("Slot1"):
		CurrSlot = 1
	if Input.is_action_just_pressed("Slot2"):
		CurrSlot = 2
	if Input.is_action_just_pressed("Slot3"):
		CurrSlot = 3

func CheckMouse():
	if CurrSlot == 2:
		var MousePos: Vector2 = get_global_mouse_position()
		
		var DistanceX: float = MousePos.x - HandAnchor.global_position.x
		var DistanceY: float = MousePos.y - HandAnchor.global_position.y
		
		var FinalX: float = clamp(MousePos.x, HandAnchor.global_position.x -80, HandAnchor.global_position.x + 100) + DistanceX
		var FinalY: float = clamp(MousePos.y, HandAnchor.global_position.y -100, HandAnchor.global_position.y + 100) + DistanceY
		
		Hand.global_position.x = lerpf(Hand.global_position.x, FinalX - DistanceX, 0.3)
		Hand.global_position.y = lerpf(Hand.global_position.y, FinalY - DistanceY, 0.3)
	else:
		Hand.global_position = HandAnchor.global_position

func CheckLight():
	if CurrSlot == 2:
		Light.global_position = get_global_mouse_position()
		
		if FlashlightActive:
			Light.visible = true
		else:
			Light.visible = false

func CheckHand():
	if CurrSlot == 2:
		Hand.visible = true
		if FlashlightActive:
			var height: String = ""
			
			if Hand.global_position.y >= HandAnchor.global_position.y:
				height = "Dow"
			
			if Hand.global_position.y < HandAnchor.global_position.y - 85:
				height = "Up"
			
			
			if Hand.global_position.x <= HandAnchor.global_position.x -70:
				Hand.play("Lef" + height)
			
			if (Hand.global_position.x > HandAnchor.global_position.x -70 && Hand.global_position.x <= HandAnchor.global_position.x + 70):
				Hand.play("For" + height)
			
			if Hand.global_position.x >= HandAnchor.global_position.x + 70:
				Hand.play("Rig" + height)
			
		else:
			Hand.play("Idle")
		
	else:
		Hand.visible = false
