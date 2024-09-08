extends Label

func _on_tundra_power_changed(power):
	self.text = "Power: " + str(power)
