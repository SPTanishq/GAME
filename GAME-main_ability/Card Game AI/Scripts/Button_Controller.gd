extends Control

func _on_next_turn_pressed():
	if Global.currentTurn:
		Global.currentTurn = false
