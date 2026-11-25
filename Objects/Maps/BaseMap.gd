extends Node2D
class_name BaseMap

@onready var Images: Sprite2D = $Sprite ## The Room background Images.
@onready var ImagesBG: Sprite2D = $MapBehind ## The Room background Images.
@onready var Effects: ColorRect = $Effects ## The Rect with the Panoramic Distortion.
@onready var Hud: CanvasLayer = $Hud
@onready var ButtonHold: Control = $Hud/ButtonHold
@onready var Vignette: ColorRect = $Vignette

@export var PathToFiles: String ## Path for Loading.
@export var MoveButton: PackedScene
@export var CurrentLocation: int = 1 ## Used as the Starting Room as well.
 
@export var ColorBG: String ## Hex code Color for the BG of the Scene itself

var Game: Node2D
var Player: Node2D

var ScreenCenter: Vector2 = Vector2(576, 324)

@export var Limits: Dictionary ## Limits for the Image BG
@export var Locations: Dictionary ## Names and their numbers, Keep the names the same as in the files.
@export var RoomData: Dictionary ## Holds data like what objects it has and what rooms it leads to.
@export var EnemyPathGuide: Dictionary ## Dictionary that says Where Enemies can Go

func _ready():
	DictionarySetup()
	Setup()
	RoomChange(CurrentLocation)
	SetLimits()

func Setup(): ## Setup stuff
	RenderingServer.set_default_clear_color(Color(ColorBG))

func DictionarySetup(): ## A way to set up the dictionaries without it being an export var bc export dictionaries SUCK to edit
	pass

func _process(_d: float):
	CheckButtonPos()
	ProcessVignette()
	RoomProcess()

var NormalMousePos: Vector2
var DefaultI: float = 5.0
var StrongI: float = 1.5
func ProcessVignette():
	Vignette.set_instance_shader_parameter("X", NormalMousePos[0])
	Vignette.set_instance_shader_parameter("Y", NormalMousePos[1])
	
	var CurrI: float = Vignette.get_instance_shader_parameter("I")
	if Player.FlashlightActive:
		Vignette.set_instance_shader_parameter("I", lerp(CurrI, StrongI, 0.25))
	else:
		Vignette.set_instance_shader_parameter("I", lerp(CurrI, DefaultI, 0.06))

var XHalf: float # Window half = 576
var YHalf: float # Window half = 324
func SetLimits():
	XHalf = (Images.texture.get_size().x * 0.5) * Images.scale.x
	YHalf = (Images.texture.get_size().y * 0.50) * Images.scale.y
	
	Limits["X-"] = 1152 - XHalf
	Limits["X+"] = XHalf
	Limits["Y-"] = 648 - YHalf
	Limits["Y+"] = YHalf

func Movement(dir: Vector2, sp: float):
	Images.global_position -= dir * (sp * NewGlob.Delta)
	
	Images.global_position.x = clamp(Images.global_position.x, Limits["X-"], Limits["X+"])
	Images.global_position.y = clamp(Images.global_position.y, Limits["Y-"], Limits["Y+"])
	ImagesBG.global_transform = Images.global_transform

func CheckButtonPos():
	for b: TextureButton in MovementButtons:
		var dir: String = MovementButtons[b][0]
		var crd: float = MovementButtons[b][1]
		if dir == "Lef":
			if Images.global_position.x >= crd:
				b.visible = true
			else:
				b.visible = false
		
		if dir == "Rig":
			if Images.global_position.x >= crd:
				b.visible = false
			else:
				b.visible = true
		
		if dir == "Dow":
			if Images.global_position.y >= crd:
				b.visible = false
			else:
				b.visible = true
		
		if dir == "Up":
			if Images.global_position.y >= crd:
				b.visible = true
			else:
				b.visible = false

var MovementButtons: Dictionary = {} ## The loaded Movement Buttons and their Visible Positions that will be Deleted When a Room Change is done.
func RoomChange(To: int):
	var STRto: String = str(To)
	var room = Locations[STRto]["Name"]
	Images.texture = Locations[STRto]["Image"]
	Images.global_position = ScreenCenter
	CurrentLocation = To
	
	MovementButtons.clear()
	ButtonHold.free()
	
	Images.self_modulate = Color()
	ImagesBG.self_modulate = Color()
	await get_tree().create_timer(0.25, false, false).timeout
	Images.self_modulate = Color(1, 1, 1, 1)
	ImagesBG.self_modulate = Color(1, 1, 1, 1)
	
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
		Btn.name = BtData[0]
		ButtonHold.add_child(Btn)
		MovementButtons[Btn] = BtData[4]
	
	CheckButtonPos()
	ImagesBG.global_transform = Images.global_transform
	ImagesBG.visible = false

func RoomProcess():
	pass
