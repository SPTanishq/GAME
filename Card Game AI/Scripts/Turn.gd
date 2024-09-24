extends Label

func _process(delta):
	self.text = "Turn: " + str(Global.turn)
