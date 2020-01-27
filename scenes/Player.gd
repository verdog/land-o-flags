extends KinematicBody2D

export var gravity = Vector2(0, 1)
export var friction_ground = Vector2(0.8, 1)
export var friction_air    = Vector2(0.9, 1)
export var acceleration_x = Vector2(8, 0)
export var acceleration_jump = Vector2(0, -200)
export var speed_max = 300
export var master_snap = Vector2(0, 4)

var variable_jump_flag = false
var last_input_dir = 1

var state = "normal"

var buffered_velocity = Vector2.ZERO

onready var sprite = $"./AnimatedSprite"

signal attack
signal damaged
signal frame_changed

var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("attack", $"./Sword", "player_attack")

func _process(delta):
	# sprites
	if abs(velocity.x) > 10:
		sprite.play("run")
	else:
		sprite.play("idle")
	
#	if last_input_dir != 1:
#		sprite.flip_h = true
#	else:
#		sprite.flip_h = false
		
	if Input.is_action_just_pressed("imp_a") and state != "invuln" and _global._gamestate != _global.STATE.LOSE:
		emit_signal("attack")

func _physics_process(delta):
	var snap = master_snap
	
	# input
	if state != "invuln" \
	and (_global._gamestate == _global.STATE.CLIMB or _global._gamestate == _global.STATE.WIN):
		if Input.is_action_pressed("imp_right"):
			velocity += acceleration_x
			snap = master_snap
			last_input_dir = 1
		if Input.is_action_pressed("imp_left"):
			velocity -= acceleration_x
			snap = master_snap
			last_input_dir = -1
		if Input.is_action_just_pressed("inp_up") and is_on_floor():
			velocity = Vector2(velocity.x, acceleration_jump.y)
			variable_jump_flag = true
			snap = Vector2.ZERO
			$"./Jump".play()
		
	if Input.is_action_just_released("inp_up"):
		variable_jump_flag = false
	
	velocity += buffered_velocity
	buffered_velocity = Vector2.ZERO
	
	# external
	if !is_on_floor() and Input.is_action_pressed("inp_up") and variable_jump_flag == true:
		velocity += gravity/2
	elif !is_on_floor():
		velocity += gravity
	
	if is_on_floor() and !(Input.is_action_pressed("imp_left") or Input.is_action_pressed("imp_right")):
		velocity *= friction_ground
	else:
		velocity *= friction_air
		
	# cap
	velocity = velocity.clamped(speed_max)
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)

func hurt(dmg):
	if state != "invuln":
		$"./Hit".play()
		emit_signal("damaged")
		buffered_velocity = Vector2(-300, -300)
		$"./Damage_Timer".start()
		state = "invuln"
		$"./Stars".visible = true
		
func _on_Damage_Timer_timeout():
	state = "normal"
	$"./Stars".visible = false

