extends Node2D

var Player: Node2D

var EnemyLocation: Dictionary = {}

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
	pass
