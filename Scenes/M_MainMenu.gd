extends Node2D

var accel: float = 1.0 ## Accel of the hud elenents
var shouldmove: bool = true ## If the hud elements should move

#Lmao the comments Make it look like AI

@onready var TrickleMenu: TextureRect = $Menu/TextureRect
var TrickleImage: String = "res://Objects/Hud/chad.jpg"
var ShokuImage: String = "res://icon.svg"

@onready var PlayButton: Button = $Menu/PlayButton
@onready var ShopButton: Button = $Menu/ShopButton
@onready var ModesButton: Button = $Menu/ModesButton
@onready var QuitButton: Button = $Menu/QuitButton

func _ready():
	await get_tree().create_timer(1.5, false, false).timeout
	shouldmove = false

func _process(_d):
	CheckShouldMove()
	TrickleTrnsfrm()

func CheckShouldMove():
	if shouldmove:
		TrickleMenu.global_position.x += 2000 * accel * NewGlob.Delta
		PlayButton.global_position.y -= 2500 * accel * NewGlob.Delta
		ShopButton.global_position.y -= 2500 * accel * NewGlob.Delta
		ModesButton.global_position.y -= 2500 * accel * NewGlob.Delta
		QuitButton.global_position.y -= 1050 * accel * NewGlob.Delta
		accel = accel * 0.85

var CanShoku: bool = false
var ShokuHits: int = 0
func TrickleTrnsfrm():
	var rng: int = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1].pick_random()
	
	if !CanShoku:
		if ShokuHits == 50:
			CanShoku = true
	
	if CanShoku:
		if rng == 1:
			ShokuHits += 1
		
		if ShokuHits == 6:
			TrickleMenu.texture = load(ShokuImage)
		
		if ShokuHits >= 7:
			TrickleMenu.texture = load(TrickleImage)
			ShokuHits = 0

# I tried to make it work with one function for all of them but idk how to do that yet
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
