extends Label

func _process(delta):
	self.text = str(Global.location_data["tundra"]["player_power"])
