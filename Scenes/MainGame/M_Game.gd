extends Node2D

var Player: Node2D
var Map: Node2D

var NightN: int = 1
var Hour: int = 0
var NTimer: float = 0.0

var EnemyLocation: Dictionary = {}
@onready var HudLayer: CanvasLayer = $Hud
@onready var HourLabel: Label = $Hud/Hour
@onready var PowerLabel: Label = $Hud/Power
@onready var TimerLabel: Label = $Hud/Timer
@onready var NightLabel: Label = $Hud/Night

func _ready():
	LoadMap()
	LoadEnemies()
	LoadPlayer()
	
	NightLabel.text = "Night: " + str(NightN)



var MapPat: String = "res://Objects/Maps/" + PlayerData.PlayerMap + "/" + PlayerData.PlayerMap + ".tscn"
func LoadMap():
	if PlayerData.ModdedMap:
		MapPat = "user://Mods/Maps/" + PlayerData.PlayerMap + "/" + PlayerData.PlayerMap + ".tscn"
	
	if ResourceLoader.exists(MapPat):
		Map = (load(MapPat) as PackedScene).instantiate()
		add_child(Map)
	else:
		print("Invalid Map Path.")



var PlayerSpawnerPath: String = "res://Objects/Survivors/" + PlayerData.PlayerSurv + "/" + PlayerData.PlayerSurv + ".tscn"
func LoadPlayer():
	if PlayerData.ModdedSurv:
		PlayerSpawnerPath = "user://Mods/Players/" + PlayerData.PlayerSurv + "/" + PlayerData.PlayerSurv + ".tscn"
	
	if ResourceLoader.exists(PlayerSpawnerPath):
		Player = (load(PlayerSpawnerPath) as PackedScene).instantiate()
		Player.global_position = Vector2(0, 0)
		add_child(Player)
	else:
		print("Invalid Player Path.")



func LoadEnemies():
	pass



func _process(_d: float):
	TimeProcess()
	HudUpdate()

func TimeProcess():
	NTimer += 0.1
	NTimer = snapped(NTimer, 0.15)
	if NTimer >= 200:
		NTimer = 0.0
		Hour += 1

func HudUpdate():
	TimerLabel.text = "Timer: " + str(NTimer)
	HourLabel.text = "Hour: " + str(Hour)
	PowerLabel.text = "Power: " + str(Player.Power)
