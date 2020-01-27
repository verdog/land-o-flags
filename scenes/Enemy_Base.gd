extends KinematicBody2D

var playertype = preload("res://scenes/Player.gd")

var velocity = Vector2(0,0)
export var gravity = Vector2(0, 5)
export var cap = 300
export var hp = 1
export var damage = 1

var active = false

func on_activate():
	pass

func custom_physics():
	pass

func _physics_process(delta):
	if active:
		custom_physics()
	velocity += gravity
	velocity = velocity.clamped(cap)
	velocity = move_and_slide(velocity, Vector2.UP)

func damage(dmg):
	hp -= dmg
	
	if hp <= 0:
		queue_free()

func _on_Area2D_body_entered(body):
	if body is playertype and active == false:
		active = true
		on_activate()

func _on_Hurtbox_body_entered(body):
	if body is playertype and active == true:
		body.hurt(damage)
