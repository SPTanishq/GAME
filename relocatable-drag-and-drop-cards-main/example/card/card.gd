class_name Card
extends Control

@export var card_texture:Texture
@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $Label
@onready var name_label: Label = %NameLabel
@onready var state_machine: CardStateMachine = $CardStateMachine
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_detector: Area2D = $CardsDetector
@onready var home_field: Field
@onready var type = []
var typeIndex = 0
var index: int = 0

func _ready():
	type = Global.itemData["cards"]
	var parent = get_parent()
	if parent:
		# Manually find the index of this card within the parent because the get_child_index() function no workey
		for i in range(parent.get_child_count()):
			if parent.get_child(i) == self:
				typeIndex = i
				break
	type = type[typeIndex]
	name_label.text = name


func _input(event):
	state_machine.on_input(event)


func _on_gui_input(event):
	state_machine.on_gui_input(event)
	

func _on_mouse_entered():
	state_machine.on_mouse_entered()


func _on_mouse_exited():
	state_machine.on_mouse_exited()
