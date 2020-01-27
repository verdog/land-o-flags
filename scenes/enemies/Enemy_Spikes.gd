extends "res://scenes/Enemy_Base.gd"

func custom_physics():
	if is_on_floor():
		cap = 0

func damage(dmg):
	# can't hurt spikes
	pass
