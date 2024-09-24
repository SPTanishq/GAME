extends Label

func _process(delta):
	self.text = str(Global.location_data["gl"]["player_power"])
