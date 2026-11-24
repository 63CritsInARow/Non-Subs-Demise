extends BaseMap

var WindowClosed: bool = false
var WindowShined: bool = false
var KitchenDoorClosed: bool = false
var KitchenDoorShined: bool = false

func DictionarySetup():
	RoomData = {
		"Main": {
		"Objects": ["DeskTV"],
		"LeadsTo": {
			"2": ["Behind", Vector2(0, 280), 180, Vector2(436, 67), ["Dow", 350]], ## First Value is the Text or Room Name, the rest are the Position, Rotation, Size of the button, and the Side that It Shows in, in Order.
			"5": ["Kitchen", Vector2(-500, 0), -90, Vector2(436, 67), ["Lef", 700]],
			"3": ["Window", Vector2(500, 0), 90, Vector2(436, 67), ["Rig", 400]],
		},
	},
	"Behind": {
		"Objects": ["Bed", "Pillow", "DoubleDrawerSmall", "Vent"],
		"LeadsTo": {
			"1": ["Main", Vector2(0, 280), 180, Vector2(436, 67), ["Dow", 350]],
			"4": ["Bathroom", Vector2(500, 0), 90, Vector2(436, 67), ["Rig", 400]],
		},
	},
	"Window": {
		"Objects": ["OutsideWindow"],
		"LeadsTo": {
			"1": ["Main", Vector2(0, 280), 180, Vector2(436, 67), ["Dow", 350]],
		},
	},
	"Bathroom": {
		"Objects": ["Sink", "Toilet", "Shower", "Mirror"],
		"LeadsTo": {
			"1": ["Main", Vector2(0, 280), 180, Vector2(436, 67), ["Dow", 350]],
			"5": ["Kitchen", Vector2(500, 0), 90, Vector2(436, 67), ["Rig", 400]],
		},
	},
	"Kitchen Door": {
		"Objects": ["ShortHallway", "Kitchen"], #I lowk dunno what to put here lol
		"LeadsTo": {
			"1": ["Main", Vector2(0, 280), 180, Vector2(436, 67), ["Dow", 350]],
			"4": ["Bathroom", Vector2(-500, 0), -90, Vector2(436, 67), ["Lef", 700]],
		},
	},
	} ######
	Locations = {
		"1": {
		"Name": "Main", 
		"Image": Texture2D,
	},
	"2": {
		"Name": "Behind",
		"Image": Texture2D,
	},
	"3": {
		"Name": "Window",
		"Image": Texture2D,
		"WndwBrght": load("res://Objects/Maps/Apartment/Sprites/WindowBG.png"),
		"WndwClose": load("res://Objects/Maps/Apartment/Sprites/WindowClose.png"),
	},
	"4": {
		"Name": "Bathroom",
		"Image": Texture2D,
		"Clsd": load("res://Objects/Maps/Apartment/Sprites/BathroomBG.png")
	},
	"5": {
		"Name": "Kitchen Door",
		"Image": Texture2D,
		"DoorClsd": load("res://Objects/Maps/Apartment/Sprites/KitchenDoor.png"),
		"DoorBG": load("res://Objects/Maps/Apartment/Sprites/KitchenBG.png"),
	},
	"6": {
		"Name": "Kitchen Camera",
		"Image": Texture2D,
	},
	"7": {
		"Name": "Hallway Camera",
		"Image": Texture2D,
	},
	} ######
	Limits = {
		"Y+": 0,
		"Y-": -271,
		"X+": 49,
		"X-": -747,
	}
	for r in Locations:
		var n: String = Locations[r]["Name"]
		Locations[r]["Image"] = load(PathToFiles + "Sprites/" + n + ".png")

func RoomProcess():
	if CurrentLocation in [1, 2]:
		ImagesBG.visible = false
	
	if CurrentLocation == 3:
		if Player.CurrSlot == 2:
			if Player.FlashlightActive:
				ImagesBG.texture = Locations["3"]["WndwBrght"]
				ImagesBG.visible = true
				WindowShined = true
			else:
				WindowShined = false
				ImagesBG.visible = false
		
		if Player.CurrSlot == 1:
			if Input.is_action_pressed("Mouse1"):
				Images.texture = Locations["3"]["WndwClose"]
				WindowClosed = true
			else:
				Images.texture = Locations["3"]["Image"]
				WindowClosed = false
	
	if CurrentLocation == 5:
		if Player.CurrSlot == 2:
			ImagesBG.texture = Locations["5"]["DoorBG"]
			if Player.FlashlightActive:
				ImagesBG.visible = true
				KitchenDoorShined = true
			else:
				KitchenDoorShined = false
				ImagesBG.visible = false
		
		if Player.CurrSlot == 1:
			ImagesBG.texture = Locations["5"]["DoorClsd"]
			if Input.is_action_pressed("Mouse1"):
				KitchenDoorClosed = true
				ImagesBG.visible = true
			else:
				ImagesBG.visible = false
				KitchenDoorClosed = false
	
	if CurrentLocation == 4:
		if Player.CurrSlot == 2:
			ImagesBG.texture = Locations["4"]["Clsd"]
			if Player.FlashlightActive:
				ImagesBG.visible = true
				KitchenDoorShined = true
			else:
				KitchenDoorShined = false
				ImagesBG.visible = false
