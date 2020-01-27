extends "res://scenes/Enemy_Base.gd"

var can_stop = false

var has_fallen = false

func on_activate():
	gravity = Vector2(0, 8)
	$"./Timer".start()
	if not has_fallen:
		$"./Fall".play()
	has_fallen = true

func custom_physics():
	if velocity.length() < 2 and can_stop:
		self.active = false
		self.velocity = Vector2.ZERO
		
	if is_on_floor():
		velocity *= 0.8

func damage(dmg):
	# can't kill a rock
	pass

func _on_Timer_timeout():
	can_stop = true
