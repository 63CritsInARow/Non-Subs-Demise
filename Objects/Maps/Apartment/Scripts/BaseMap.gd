extends Node2D
class_name BaseMap

@onready var Images: Sprite2D = $Sprite ## The Room background Images.
@onready var Effects: ColorRect = $ColorRect ## The Rect with the Panoramic Distortion.
@onready var Hud: CanvasLayer = $Hud

@export var PathToFiles: String = "res://Objects/Maps/Apartment/" ## Path for Loading.
@export var MoveButton: PackedScene
@export var DarkVignette: PackedScene
@export var CurrentLocation: int = 1 ## Used as the Starting Room as well.

var Darkness: Node2D ## The loaded Darkness Vignette that Follows the Mouse.


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
			"2": ["Behind", Vector2(104, 560), 180, Vector2(436, 67), Vector2(2, 2)], ## First Value is the Text or Room Name, the rest are the Position, Rotation, and Size of the button in order, and the Minimum Position to Show it.
			"4": ["Bathroom", Vector2(-172, 312), -90, Vector2(436, 67), Vector2(2, 2)],
		},
	},
	"Behind": {
		"Objects": ["Bed", "Pillow", "DoubleDrawerSmall", "Vent"],
		"LeadsTo": {
			"4": ["Bathroom", Vector2(879, 312), 180, Vector2(436, 67), Vector2(2, 2)],
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
	var STRto: String = str(To)
	var room = Locations[STRto]
	var Current: String = Locations[str(CurrentLocation)]
	Images.texture = load(PathToFiles + "Sprites/" + room + ".png")
	CurrentLocation = To
	
	for btn in MovementButtons: # This is being strange...
		btn.queue_free()
		MovementButtons.erase(btn)
	
	for lead: String in RoomData[Current]["LeadsTo"]:
		print(lead)
		var BtData: Array = RoomData[Current]["LeadsTo"][lead]
		print(BtData)
		var Btn: TextureButton = MoveButton.instantiate()
		Btn.LeadsTo = int(lead)
		Btn.position = BtData[1]
		Btn.rotation_degrees = BtData[2]
		Btn.size = BtData[3]
		Hud.add_child(Btn)
		MovementButtons.append(Btn)
