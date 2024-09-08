extends Node

signal cardMoved

var itemData = {}
@export_file var dataFilePath = "res://Data/CardData.json"
@export var MAX_CARDS: int = 3
var turn: int = 1
var currentTurn: bool = true:
	set(value):
		if value:
			turn += 1
			energy = turn * 2
var energy = 2

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

func _on_card_moved(card):
	cardMoved.emit(card)

func _input(event):
	if event.is_action_pressed("Space"):
		currentTurn = !currentTurn
