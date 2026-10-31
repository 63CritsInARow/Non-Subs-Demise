extends Node2D
class_name BaseSurvivor

@export var Name: String
@export var BaseHp: float = 100.0
@export var BaseBreath: float = 100.0 ## For things like the mask, or holding your breath even, idk
@export var BasePower: float = 100.0

@export var FlashLight: PackedScene
@export var CameraScene: PackedScene
@export var MaskScene: PackedScene

@onready var HandAnchor: Marker2D = $Anchor
@onready var Hand: AnimatedSprite2D = $Hand
@onready var ToolHud: ItemList = $Hud/ToolHud

var Game: Node2D
var Light: Node2D
var Camera: Node2D
var Mask: Node2D

var FlashlightActive: bool = false
var CameraActive: bool = false
var CameraOut: bool = false

var Interacting: Dictionary = {
	"IsInter": false,
	"Objects": [],
}
var CurrSlot: int = 1
var Power: float = 100.0
var CanUseCamera: bool = true
var CanUseFlash: bool = true
var CanInteract: bool = true
var CanUseMask: bool = true

var ShowToolBar: bool = true

func _ready():
	Game = get_tree().get_first_node_in_group("Game")
	LoadTools()

func LoadTools():
	Light = FlashLight.instantiate()
	Light.Player = self
	Light.visible = false
	Hand.add_child(Light)
	
	Camera = CameraScene.instantiate()
	Camera.Player = self
	add_child(Camera)
	
	Mask = MaskScene.instantiate()
	Mask.Player = self
	add_child(Mask)

func _process(_d: float):
	CheckMouse()
	CheckHand()
	CheckLight()
	CheckToolBar()
	CheckCamera()

func _input(_e: InputEvent):
	if CurrSlot == 2:
		if Input.is_action_pressed("Flashlight"):
			FlashlightActive = true
		else:
			FlashlightActive = false
	
	if Input.is_action_just_pressed("Slot1"):
		CurrSlot = 1
		ToolHud.select(0)
	if Input.is_action_just_pressed("Slot2"):
		CurrSlot = 2
		ToolHud.select(1)
	if Input.is_action_just_pressed("Slot3"):
		CurrSlot = 3
		ToolHud.select(2)
	if Input.is_action_just_pressed("Slot4"):
		CurrSlot = 4
		ToolHud.select(3)
	if Input.is_action_just_pressed("ShowToolBar"):
		ShowToolBar = !ShowToolBar

func CheckToolBar():
	if ShowToolBar:
		ToolHud.global_position.y = lerp(ToolHud.global_position.y, 653.0, 0.2)
	else:
		ToolHud.global_position.y = lerp(ToolHud.global_position.y, 493.0, 0.2)

func CheckPower():
	Power = snapped(Power, 0.001)

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
		#Hand.global_position = HandAnchor.global_position
		Hand.global_position.x = lerpf(Hand.global_position.x, 1100, 0.3)
		Hand.global_position.y = lerpf(Hand.global_position.y, 800, 0.3)

func CheckLight():
	if CurrSlot == 2:
		if FlashlightActive:
			Light.visible = true
			Power -= Light.Drain
			CheckPower()
		else:
			Light.visible = false

func CheckHand():
	if CurrSlot == 2:
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

func CheckCamera():
	if CurrSlot == 3:
		if Camera.Sprite.animation != "Up":
			Camera.FlipUp()
		Camera.visible = true
	else:
		if Camera.Sprite.animation != "Down":
			Camera.FlipDown()

func ToolBarSelected(i: int):
	CurrSlot = i + 1 #HOOOOLY I feel smart
