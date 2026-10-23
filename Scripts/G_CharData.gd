extends Node

# Still figuring out how this is even gonna work, lemme actually code the night first bro kms

var BaseGameNames: Array = ["Base"] ## Non-mod character names
var IgnoredNames: Array = ["Base"] ## Names that won't appear in the selection, Includes both enemy and survivor
var UnlockableNames: Array = [] ## Includes both enemy and survivor

var PlayerChar: String = "Default" ## Current Survivor
var PlayersList: Dictionary = { ## List of... wait, this should be in the char json
	"Default": ""
	
}

var Enemies: Dictionary = {
	"Trickle": "",
	"Shoku": "",
	"Limon": "",
	"Zion": ""
	
}
var SelectedEnemies: Dictionary = {
	"Trickle": 20,
}
