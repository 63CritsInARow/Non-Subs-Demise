extends Node2D
class_name BaseMap

@onready var Images: Sprite2D = $Sprite ## The Room background Images.
@onready var Effects: ColorRect = $ColorRect ## The Rect with the Panoramic Distortion.
@onready var Hud: CanvasLayer = $Hud
@onready var ButtonHold: Control = $Hud/ButtonHold

@export var PathToFiles: String = "res://Objects/Maps/Apartment/" ## Path for Loading.
@export var MoveButton: PackedScene
@export var DarkVignette: PackedScene
@export var CurrentLocation: int = 1 ## Used as the Starting Room as well.

var Darkness: Node2D ## The loaded Darkness Vignette that Follows the Mouse.
var Game: Node2D

var Limits: Dictionary = {
	"Y+": 0,
	"Y-": -271,
	"X+": 49,
	"X-": -747,
}
var Locations: Dictionary = { ## Names and their numbers, Keep the names the same as in the files.
	"1": "Main",
	"2": "Behind",
	"3": "Window",
	"4": "Bathroom",
	"5": "Kitchen Door",
	"6": "Kitchen Camera",
	"7": "Hallway Camera",
}
@export var RoomData: Dictionary = { ## Holds data like what objects it has and what rooms it leads to.
	"Main": {
		"Objects": ["DeskTV"],
		"LeadsTo": {
			"2": ["Behind", Vector2(0, 280), 180, Vector2(436, 67), ["Down", -500]], ## First Value is the Text or Room Name, the rest are the Position, Rotation, Size of the button, and the Side that It Shows in, in Order.
			"4": ["Bathroom", Vector2(-500, 0), -90, Vector2(436, 67), ["Left", -500]],
			"3": ["Window", Vector2(500, 0), 90, Vector2(436, 67), Vector2(2, 2)],
		},
	},
	"Behind": {
		"Objects": ["Bed", "Pillow", "DoubleDrawerSmall", "Vent"],
		"LeadsTo": {
			"1": ["Main", Vector2(0, 280), 180, Vector2(436, 67), Vector2(2, 2)],
			
		},
	},
	"Window": {
		"Objects": ["Bed", "Pillow", "DoubleDrawerSmall", "Vent"],
		"LeadsTo": {
			"1": ["Main", Vector2(608, 560), 180, Vector2(436, 67), Vector2(2, 2)],
			
		},
	},
	"Bathroom": {
		"Objects": ["Bed", "Pillow", "DoubleDrawerSmall", "Vent"],
		"LeadsTo": {
			"1": ["Main", Vector2(608, 560), 180, Vector2(436, 67), Vector2(2, 2)],
			
		},
	},
	"Kitchen Door": {
		"Objects": ["Bed", "Pillow", "DoubleDrawerSmall", "Vent"],
		"LeadsTo": {
			"1": ["Main", Vector2(608, 560), 180, Vector2(436, 67), Vector2(2, 2)],
			
		},
	},
}
func _ready():
	DictionarySetup()
	RoomChange(CurrentLocation)
	SetLimits()

func DictionarySetup():
	pass

func _process(_d: float):
	pass

func SetLimits(): # Fixed, it was the TextureRect tweaking
	var XHalf: float = (Images.texture.get_size().x * 0.5) * Images.scale.x
	var YHalf: float = (Images.texture.get_size().y * 0.50) * Images.scale.y
	
	Limits["X-"] = 1152 - XHalf
	Limits["X+"] = XHalf
	Limits["Y-"] = 648 - YHalf
	Limits["Y+"] = YHalf

func Movement(dir: Vector2, sp: float):
	Images.global_position -= dir * (sp * NewGlob.Delta)
	
	Images.global_position.x = clamp(Images.global_position.x, Limits["X-"], Limits["X+"])
	Images.global_position.y = clamp(Images.global_position.y, Limits["Y-"], Limits["Y+"])

var MovementButtons: Array = [] ## The loaded Movement Buttons that will be Deleted When a Room Change is done.
func RoomChange(To: int):
	MovementButtons.clear()
	ButtonHold.free()
	
	var STRto: String = str(To)
	var room = Locations[STRto]
	#var Current: String = Locations[str(CurrentLocation)]
	Images.texture = load(PathToFiles + "Sprites/" + room + ".png")
	CurrentLocation = To
	
	
	await get_tree().process_frame
	
	var bttnhold = Control.new()
	bttnhold.name = "ButtonHold"
	Hud.add_child(bttnhold)
	ButtonHold = bttnhold
	ButtonHold.global_position = Vector2(576, 324)
	
	var ButtonLeads: Dictionary = RoomData[room]["LeadsTo"]
	for lead: String in ButtonLeads:
		var BtData: Array = RoomData[room]["LeadsTo"][lead]
		var Btn: TextureButton = MoveButton.instantiate()
		Btn.LeadsTo = int(lead)
		Btn.position.x = (BtData[1])[0] - ((BtData[3])[0] * 0.5)
		Btn.position.y = (BtData[1])[1] - ((BtData[3])[1] * 0.5)
		Btn.rotation_degrees = BtData[2]
		Btn.size = BtData[3]
		ButtonHold.add_child(Btn)
		MovementButtons.append(Btn)
