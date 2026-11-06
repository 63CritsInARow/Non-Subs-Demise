extends Area2D

@export var Drain: float = 0.001

var Player: Node2D

func _ready():
	z_index = Player.Hand.z_index - 1

func _process(_d: float):
	CheckPosition()
	CheckVisible()

func CheckPosition():
	if Player.FlashlightActive:
		global_position = get_global_mouse_position()

func CheckVisible():
	visible = Player.FlashlightActive
