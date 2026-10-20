extends Node
var Delta: float = 0.016

var timescale: float = 1.0
var ShowSprites: bool = true

func _process(d: float) -> void:
	Engine.time_scale = timescale
	Delta = clamp(d, 0.0, (0.016 * Engine.time_scale))

func HideSprtes():
	ShowSprites = !ShowSprites
	if ShowSprites == true:
		get_tree().call_group("Sprite", "set", "visible", true)
