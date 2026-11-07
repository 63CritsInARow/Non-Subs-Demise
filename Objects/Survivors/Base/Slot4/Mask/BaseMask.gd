extends Node2D
class_name BaseMask

var Player: Node2D

@export var Drain: float = 0.001

func _ready():
	pass

func _process(_d: float):
	CheckLower()

func CheckLower(): # Find a way to make it optimized
	if Player.MaskDown:
		global_position.y = lerpf(global_position.y, 0, 0.2)
	else:
		global_position.y = lerpf(global_position.y, -700, 0.2)
