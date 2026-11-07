extends Node2D
class_name BaseCamera

@onready var Sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var Drain: float = 0.001

var Player: Node2D

func _ready():
	pass

func _process(_d: float):
	pass

func FlipUp():
	Sprite.visible = true
	Sprite.play("Up")
	await Sprite.animation_finished
	Player.CameraActive = true

func FlipDown():
	Sprite.play("Down")
	Player.CameraActive = false
	await Sprite.animation_finished
	Sprite.visible = false
