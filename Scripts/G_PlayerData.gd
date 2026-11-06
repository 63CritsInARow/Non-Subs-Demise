extends Node

var PlayerSurv: String = "Base" ## Current Survivor
var ModdedSurv: bool = false

var PlayerMap: String = "Apartment" ## Current Map
var ModdedMap: bool = false

var GeneralUnlocks: Dictionary = { ## Unlocks related to the game
	"Survivors": [],
	"Enemies": [],
	"General Achievements": [],
}
var CharUnlocks: Dictionary = { ## Unlocks for the current character selected
	
}
var EnemyData: Dictionary = { ## Unlocks, data, and tracked actions from all enemies
	
}
var SelectedEnemies: Dictionary = { ## Selected Enemies for the Night
	"Trickle": 20,
}
var Loadout: Dictionary = {
	"1": "Interact",
	"2": "Flashlight",
	"3": "Camera",
	"4": "Mask",
}
