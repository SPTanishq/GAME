extends Node

signal cardMoved

var itemData = {}
@export_file var dataFilePath = "res://Data/CardData.json"
@export var MAX_CARDS: int = 3
@export var currentTurn: bool = true #true = user
var energy: int = 20
var turn: int = 1

var player_cards = ["kaboom","bunker","sniper","resupply","copycat","overcharge"] # store player's hand
var ai_cards = ["kaboom","bunker","sniper","resupply","copycat","overcharge"] # store AI's hand


func _ready():
	itemData = 	Load_json_file(dataFilePath)


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

#connects all the fields together
func _on_card_moved(card):
	cardMoved.emit(card)
	


func _input(event):
	if event.is_action_pressed("Space"):
		currentTurn = !currentTurn
		if currentTurn:
			turn += 1
			energy = 2*turn
		
