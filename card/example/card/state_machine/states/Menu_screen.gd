class_name MainMenu
extends Node2D

@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/play_button as Button
@onready var Exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var Start_level = preload("res://example/Main.tscn") as PackedScene



func _ready():
	play_button.button_down.connect(on_play_pressed)
	Exit_button.button_down.connect(on_exit_pressed)
	
func on_play_pressed() -> void:
	get_tree().change_scene_to_packed(Start_level)



func on_exit_pressed() -> void:
	get_tree().quit()
