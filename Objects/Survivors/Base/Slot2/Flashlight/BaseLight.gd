extends Area2D
class_name BaseLight

@export var Drain: float = 0.001

var Player: Node2D

func _process(_d: float):
	CheckVisible()

func CheckVisible():
	visible = Player.FlashlightActive
