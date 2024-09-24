extends Label

func _process(delta):
	self.text = "Energy: " + str(Global.energy)
