extends "res://scenes/Enemy_Base.gd"

var buffered_velocity = Vector2()
export var yump = Vector2(0, -200)

func _on_Yump_timeout():
	# he yump
	buffered_velocity = yump
	$"./Jump".play()

func custom_physics():
	velocity += buffered_velocity
	buffered_velocity = Vector2.ZERO
