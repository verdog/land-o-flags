extends Node2D

var enemytype = preload("res://scenes/Enemy_Base.gd")

onready var player = $".."
onready var mount_r = $"../Sword_Mount"
onready var psprite = $"../AnimatedSprite"

var state = "hold"

func _physics_process(delta):
	if state == "hold":
		position = mount_r.position

func _on_AnimatedSprite_frame_changed():
	if psprite.animation == "run" and state == "hold":
		if psprite.frame == 1:
			position = mount_r.position + Vector2(0, -1)
		else:
			position = mount_r.position

func player_attack():
	# move sword
	if state == "hold":
		state = "attack"
		var tween = Tween.new()
		add_child(tween)
		tween.interpolate_property(self, "position", 
			position, position + Vector2(16, 0), .1, 
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()

		$"./swing".play()

		yield(tween, "tween_completed")
		state = "hold"

func _on_Area2D_body_entered(body):
	if body is enemytype and state == "attack":
		$"../Hit_Enemy".play()
		body.damage(1)
