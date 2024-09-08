class_name MainMenu
extends Node2D

@onready var play_button = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/play_button as Button
@onready var Exit_button = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var Start_level = preload("res://Scenes/Main.tscn") as PackedScene

func on_play_pressed():
	get_tree().change_scene_to_packed(Start_level)

func on_exit_pressed():
	get_tree().quit()
