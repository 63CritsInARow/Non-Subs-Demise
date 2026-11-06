extends Node2D

@onready var Images: TextureRect = $TextureRect
@onready var Effects: ColorRect = $ColorRect

@export var Limits: Dictionary = {
	"Y+": 134.4,
	"Y-": -134.4,
	"X+": 50,
	"X-": -393.599,
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
	pass

func _process(_d: float):
	pass

func Movement(dir: Vector2, sp: float):
	Images.global_position -= dir * (sp * NewGlob.Delta)
	
	var Xmin: float = Limits["X-"]
	var Xmax: float = Limits["X+"]
	var Ymin: float = Limits["Y-"]
	var Ymax: float = Limits["Y+"]
	
	Images.global_position.x = clamp(Images.global_position.x, Xmin, Xmax)
	Images.global_position.y = clamp(Images.global_position.y, Ymin, Ymax)
