extends KinematicBody2D

var playertype = preload("res://scenes/Player.gd")
onready var player = $"../Player"
onready var drop_timer = $"./Pickup_Timer"
onready var podium = $"../IslandGenerator/Chunk_Win/Win_Area/Top"
onready var sprite = $"./AnimatedSprite"

onready var flagcam = $"/root/Main/Alert/Viewport/Camera2D"
onready var flagview = $"/root/Main/Alert"

var player_touching = true

var velocity = Vector2()

var state = "hold"

var can_pickup = false
var blink_state = true

func _ready():
	if player != null:
		position = player.get_node("Flag_Mount_R").global_position
	
	if flagcam:	
		flagcam.target = self

func drop_flag():
	if state != "bounce" and _global._gamestate != _global.STATE.WIN:
		state = "bounce"
		velocity.x = -20
		can_pickup = false
		drop_timer.start()
		if flagview:
			flagview.visible = true
	
func pickup_flag():
	if _global._gamestate != _global.STATE.LOSE:
		state = "hold"
		$"./FlagCam_Timer".start()
		$"./Pickup".play()

func _physics_process(delta):
	if state == "hold":
		if player != null:
			position = player.get_node("Flag_Mount_R").global_position
	if state == "bounce":
		if can_pickup and player_touching:
			pickup_flag()
			return
		
		if is_on_floor():
			velocity.y = -100
		else:
			velocity += player.gravity/3
		
		velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_body_entered(body):
	if body is playertype:
		player_touching = true

func _on_Area2D_body_exited(body):
	if body is playertype:
		player_touching = false

func _on_Pickup_Timer_timeout():
	can_pickup = true

func _on_Chunk_Win_win():	
	state = "win"
	global_position = podium.global_position
	z_index = -1
	$"./Plant".play()

func _on_Player_damaged():
	drop_flag()

func _on_Blink_Timer_timeout():
	if can_pickup == false and state == "bounce":
		if blink_state == true:
			sprite.modulate = Color(1, 1, 1, .25)
		else:
			sprite.modulate = Color(1, 1, 1)
		blink_state = not blink_state
	else:
		sprite.modulate = Color(1, 1, 1)

func _on_FlagCam_Timer_timeout():
	if flagview:
		flagview.visible = false
