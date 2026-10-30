extends Node2D

var Player: Node2D

var NightN: int = 0
var Hour: int = 0
var NTimer: float = 0.0

var EnemyLocation: Dictionary = {}
@onready var HourLabel: Label = $Hud/Hour
@onready var PowerLabel: Label = $Hud/Power
@onready var TimerLabel: Label = $Hud/Timer
@onready var NightLabel: Label = $Hud/Night

func _ready():
	LoadEnemies()
	LoadPlayer()

var PlayerSpawnerPath: String = "res://Objects/Survivors/" + PlayerData.PlayerSurv + "/" + PlayerData.PlayerSurv + ".tscn"
func LoadPlayer():
	if PlayerData.ModdedSurv:
		PlayerSpawnerPath = "user://Mods/Players/" + PlayerData.PlayerSurv + "/" + PlayerData.PlayerSurv + ".tscn"
	
	if ResourceLoader.exists(PlayerSpawnerPath):
		var player: Node2D = (load(PlayerSpawnerPath) as PackedScene).instantiate()
		player.global_position = Vector2(0, 0)
		add_child(player)
	else:
		print("dnuaisgdyuasd")

func LoadEnemies():
	pass

func _process(_d: float):
	TimeProcess()
	HudUpdate()

func TimeProcess():
	NTimer += 0.1
	NTimer = snapped(NTimer, 0.15)
	if NTimer >= 80:
		NTimer = 0.0
		Hour += 1

func HudUpdate():
	TimerLabel.text = "Timer: " + str(NTimer)
	HourLabel.text = "Hour: " + str(Hour)
