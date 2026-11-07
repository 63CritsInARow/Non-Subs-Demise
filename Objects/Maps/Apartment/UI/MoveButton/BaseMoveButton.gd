extends TextureButton
class_name BaseMoveButton

var Game: Node2D
var Map: Node2D

var LeadsTo: int

func _ready():
	Game = get_tree().get_first_node_in_group("Game")
	Map = get_tree().get_first_node_in_group("Map")

func _on_pressed():
	Map.RoomChange(LeadsTo)
