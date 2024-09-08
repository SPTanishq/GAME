extends Label

func _on_grassy_lands_power_changed(power):
	self.text = "Power: " + str(power)
