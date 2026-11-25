extends Node2D
class_name BaseEnemy

@onready var timer: Timer = $Timer

@export var StartingRoom: int = 7
@export var MovingPath: Dictionary
@export var MoveTimerMax: float = 3.5

var AIlevel: int
var MapPosition: int

var Map: Node2D
var Game: Node2D
var Player: Node2D

func _ready():
	Game = get_tree().get_first_node_in_group("Game")
	Map = Game.Map
	Player = Game.Player
	
	Setup()
	GetMapData()
	
	timer.start(MoveTimerMax)
	print(MapPosition)

func Setup():
	MapPosition = StartingRoom

func GetMapData():
	pass

func MoveTimer():
	var current: String = str(MapPosition)
	if current in Map.EnemyPathGuide:
		var optionsdata: Dictionary = Map.EnemyPathGuide[current]
		var options: Array
		for r in optionsdata:
			options.append(r)
		
		var goto: String = options.pick_random()
		MapPosition = int(goto)
		print(MapPosition)
		
		timer.start(MoveTimerMax)
	else:
		var namecurrent: String = Map.Locations[str(MapPosition)]["Name"]
		var currentdata: Dictionary = Map.RoomData[namecurrent]
		var options: Array
		for r in currentdata["LeadsTo"]:
			options.append(r)
		
		var goto: String = options.pick_random()
		MapPosition = int(goto)
		print(MapPosition)
		
		timer.start(MoveTimerMax)
