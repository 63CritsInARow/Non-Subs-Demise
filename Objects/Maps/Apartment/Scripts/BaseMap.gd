extends Node2D

@onready var Images: Sprite2D = $Sprite
@onready var Effects: ColorRect = $ColorRect
@onready var Dark: Sprite2D = $Dark

var Limits: Dictionary = {
	"Y+": 0,
	"Y-": -271,
	"X+": 49,
	"X-": -747,
}
var CurrentLocation: int = 1
var Locations: Dictionary = {
	"1": "Main",
	"2": "Behind",
	"3": "Window",
	"4": "Kitchen Door",
	"5": "Kitchen Camera",
	"6": "Hallway Camera",
}
func _ready():
	SetLimits()

func SetLimits(): # Fix the thingy where it doesn't fully clamp to the borders
	var XHalf: float = (Images.texture.get_size().x * 0.5) * Images.scale.x
	var YHalf: float = (Images.texture.get_size().y * 0.50) * Images.scale.y
	
	Limits["X-"] = 1152 - XHalf
	Limits["X+"] = XHalf
	Limits["Y-"] = 648 - YHalf
	Limits["Y+"] = YHalf

func _process(_d: float):
	pass

func Movement(dir: Vector2, sp: float):
	Images.global_position -= dir * (sp * NewGlob.Delta)
	
	Images.global_position.x = clamp(Images.global_position.x, Limits["X-"], Limits["X+"])
	Images.global_position.y = clamp(Images.global_position.y, Limits["Y-"], Limits["Y+"])
