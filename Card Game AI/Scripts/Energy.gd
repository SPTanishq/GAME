extends Label

func _process(delta):
	self.text = "Energy: " + str(Global.Player_energy)
