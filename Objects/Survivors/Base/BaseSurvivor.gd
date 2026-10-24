extends Node2D
class_name BaseSurvivor

@export var Name: String
@export var BaseHp: float = 100.0
@export var FlashLight: PackedScene
@export var Loadout: Dictionary = {
	"1": "Flashlight",
	"2": "Camera",
	"3": ""
}

@onready var HandAnchor: Marker2D = $Anchor
@onready var Hand: AnimatedSprite2D = $Hand

var Game: Node2D
var FlashlightActive: bool = false

func _ready():
	Game = get_tree().get_first_node_in_group("Game")
	Hand.global_position = HandAnchor.global_position

func _process(_d: float):
	CheckMouse()

func _input(event: InputEvent):
	if Input.is_action_pressed("Flashlight"):
		FlashlightActive = true
	else:
		FlashlightActive = false

func CheckMouse():
	var MousePos: Vector2 = get_global_mouse_position()
	
	var DistanceX: float = MousePos.x - HandAnchor.global_position.x
	var DistanceY: float = MousePos.y - HandAnchor.global_position.y
	
	var FinalX: float = clamp(MousePos.x, HandAnchor.global_position.x -200, HandAnchor.global_position.x + 80) + DistanceX
	var FinalY: float = clamp(MousePos.y, HandAnchor.global_position.y -100, HandAnchor.global_position.y + 80) + DistanceY
	
	Hand.global_position.x = lerpf(Hand.global_position.x, FinalX - DistanceX, 0.3)
	Hand.global_position.y = lerpf(Hand.global_position.y, FinalY - DistanceY, 0.3)

func CheckHandAnimation():
	if FlashlightActive:
		if Hand.global_position.x >= HandAnchor.global_position.x -60:
			Hand.play("Lef")
	else:
		Hand.play("Idle")
