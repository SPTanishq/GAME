extends Node

signal cardMoved
signal game_ai_turn

var itemData = {}
@export_file var dataFilePath = "res://Data/CardData.json"
@export var MAX_CARDS: int = 3 #in a location
@export var MAX_CARDS_DECK: int = 4
@export var MAX_TURNS: int = 4
var last_round:bool = false

var location_data = {
	"tundra":{
		"player_cards": [],
		"player_power": 0,
		"ai_cards": [],
		"ai_power": 0
	},
	"gl":{
		"player_cards": [],
		"player_power": 0,
		"ai_cards": [],
		"ai_power": 0
	}
}

var turn: int = 1:
	set(value):
		if MAX_TURNS - value == 1:
			last_round = true

var currentTurn: bool = true:
	set(value):
		if value:
			turn += 1
			total_energy = turn * 2
		else:
			game_ai_turn.emit()

var total_energy = 2:
	set(value):
		Player_energy = total_energy

var Player_energy = total_energy
var player_hand = []
var ai_hand = []

func _ready():
	itemData = 	Load_json_file(dataFilePath)
	ai_hand = itemData["cards"]
	for i in 5:
		ai_hand.shuffle()
	ai_hand = ai_hand.slice(0, MAX_CARDS_DECK)

#JSON file loader
func Load_json_file(filePath: String):
	if FileAccess.file_exists(filePath):
		
		var File = FileAccess.open(filePath, FileAccess.READ)
		var fileData = JSON.parse_string(File.get_as_text())
		
		if fileData is Dictionary:
			return fileData
		else:
			print("Error reading json file")
	else:
		print("json file doesn't exist")

func _on_card_moved(card):
	cardMoved.emit(card)

#DEBUG TIMER
func _on_timer_timeout():
	pass

func _on_end_toggled(toggled_on):
	currentTurn = toggled_on
