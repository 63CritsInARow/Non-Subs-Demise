extends Node

var PlayerSurv: String = "Base" ## Current Survivor
var ModdedSurv: bool = false

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
