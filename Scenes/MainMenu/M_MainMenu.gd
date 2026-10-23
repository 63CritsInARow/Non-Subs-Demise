extends Node2D

@onready var TrickleMenu: TextureRect = $Menu/TextureRect
var TrickleImage: String = "res://Scenes/MainMenu/Hud/TrickleMenu.png"
var ShokuImage: String = "res://Scenes/MainMenu/Hud/ShokuMenu.png"

@onready var PlayButton: Button = $Menu/PlayButton
@onready var ShopButton: Button = $Menu/ShopButton
@onready var ModesButton: Button = $Menu/ModesButton
@onready var QuitButton: Button = $Menu/QuitButton
@onready var Title: TextureRect = $Menu/Title
@onready var Gear: Button = $Menu/Gear
@onready var Fade: Sprite2D = $Menu/Fade
@onready var SavesSlider: Sprite2D = $Menu/SliderBg
@onready var SavesButton: Button = $Menu/SliderBg/Saves

func _ready():
	Fade.visible = true
	await get_tree().create_timer(1.5, false, false).timeout
	shouldmove = false

func _process(_d):
	CheckShouldMove()
	TrickleLogic()

var accel: float = 1.0
var shouldmove: bool = true
func CheckShouldMove():
	if shouldmove:
		TrickleMenu.global_position.x += 2650 * accel * NewGlob.Delta
		PlayButton.global_position.y -= 2500 * accel * NewGlob.Delta
		ShopButton.global_position.y -= 2500 * accel * NewGlob.Delta
		ModesButton.global_position.y -= 2500 * accel * NewGlob.Delta
		QuitButton.global_position.y -= 1050 * accel * NewGlob.Delta
		Gear.global_position.y += 710 * accel * NewGlob.Delta
		
		Title.global_position.y += 2250 * accel * NewGlob.Delta
		Title.global_position.x -= 8000 * accel * NewGlob.Delta
		
		Fade.modulate.a = lerpf(Fade.modulate.a, 0, 0.1)
		
		accel = accel * 0.85
	
	if !(SavesToggled):
		SavesSlider.global_position.x = lerpf(SavesSlider.global_position.x, 171.0, 0.2)
	else:
		SavesSlider.global_position.x = lerpf(SavesSlider.global_position.x, -102.0, 0.2)
	
	if GearFocused:
		Gear.rotation_degrees = lerpf(Gear.rotation_degrees, 180, 0.25)
	else:
		Gear.rotation_degrees = lerpf(Gear.rotation_degrees, 0, 0.25)

var CanShoku: bool = false
var ShokuHits: int = 0
var TricklSizeThing: float = 1.0
var rise: bool = false
var ShokuTresh: int = randi_range(35, 50)
var IsShoku: bool = false
var PrevScaleY: float = 0.56
func TrickleLogic():
	var rng: int = [0,0,0,0,0,0,0,0,0,0,0,0,1].pick_random()
	
	if !CanShoku:
		if ShokuHits == ShokuTresh:
			CanShoku = true
	
	if rng == 1:
			ShokuHits += 1
	
	if CanShoku:
		if ShokuHits == ShokuTresh:
			TrickleMenu.texture = load(ShokuImage)
			IsShoku = true
			if !(TrickleMenu.scale.y == 0.56):
				PrevScaleY = TrickleMenu.scale.y
			TrickleMenu.scale.y = 0.56
		
		if ShokuHits >= (ShokuTresh + 1):
			TrickleMenu.texture = load(TrickleImage)
			ShokuHits = 0
			ShokuTresh = randi_range(6, 25)
			IsShoku = false
			TrickleMenu.scale.y = PrevScaleY
	
	if TrickleMenu.scale.y <= 0.54:
		rise = true
	if TrickleMenu.scale.y >= 0.55:
		rise = false
	
	if !IsShoku:
		if rise:
			TrickleMenu.scale.y = lerpf(TrickleMenu.scale.y, 0.56, 0.005)
		else:
			TrickleMenu.scale.y = lerpf(TrickleMenu.scale.y, 0.53, 0.005)

func _on_play_button_button_down():
	PlayButton.modulate.v = 1.5

func _on_play_button_button_up():
	PlayButton.modulate.v = 1

func _on_play_button_pressed():
	pass


func _on_shop_button_button_down():
	ShopButton.modulate.v = 1.5

func _on_shop_button_button_up():
	ShopButton.modulate.v = 1

func _on_shop_button_pressed():
	pass


func _on_modes_button_button_down():
	ModesButton.modulate.v = 1.5

func _on_modes_button_button_up():
	ModesButton.modulate.v = 1

func _on_modes_button_pressed():
	pass


func _on_quit_button_button_down():
	QuitButton.modulate.v = 1.5

func _on_quit_button_button_up():
	QuitButton.modulate.v = 1

func _on_quit_button_pressed():
	pass

var SavesToggled: bool = true
func _on_saves_button_up():
	SavesButton.modulate.v = 1.5

func _on_saves_button_down():
	SavesButton.modulate.v = 1

func _on_saves_toggled(t: bool):
	SavesToggled = t


func _on_gear_button_down():
	pass

func _on_gear_button_up():
	pass

func _on_gear_pressed():
	pass

var GearFocused: bool = true
func _on_gear_mouse_entered():
	GearFocused = false

func _on_gear_mouse_exited():
	GearFocused = true
