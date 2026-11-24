extends Node2D
class_name BaseEnemy

@export var StartingRoom: int
@export var MovingPath: Dictionary
@export var MoveTimerMax: float

var MapPosition: int

var Map: Node2D
var Game: Node2D
var Player: Node2D

func _ready():
	GetMapData()

func GetMapData():
	pass

func Move():
	var current: String = Map.Locations[MapPosition]["Name"]
	var options: Array = Map.d
