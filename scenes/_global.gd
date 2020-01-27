extends Node

enum STATE {
	CLIMB,
	WIN,
	LOSE,
	TITLE
}

var _gamestate setget set_state
var island_length = 3
var islands_claimed = 0

signal state_changed

func _ready():
	randomize()
	title()
	
func title():
	set_state(STATE.TITLE)
	_music.get_node("./Title").play()

func play_again():
	hard_reset()
	get_tree().reload_current_scene()

func hard_reset():
	island_length = 3
	islands_claimed = 0
	reset()

func reset():
	_music.change_bgm()
	set_state(STATE.CLIMB)

func lose():
	set_state(STATE.LOSE)

func set_state(state):
	_gamestate = state
	print("state changed to: ", state)
	emit_signal("state_changed")

func win_timer():
	island_length += 1
	reset()
	get_tree().reload_current_scene()

func window_reset():
	reset()
	get_tree().reload_current_scene()
	
onready var enemy_bank = load_enemies()

func load_enemies():
	var dir = Directory.new()
	var array = []
	
	var directory_path = "res://scenes/enemies"
	
	if dir.open(directory_path) == OK:
	    dir.list_dir_begin()
	    var filename = dir.get_next()
	    while filename != "":
	        if not dir.current_is_dir() and filename.get_extension() == "tscn":
	            var path = directory_path + "/" + filename
	            array.append(load(path))
	
	        filename = dir.get_next()
	
	print("loaded ", len(array), " enemies.")
	
	array.append(null)
	
	return array

func how_to_play_button():
	print("how to play")
	pass

func start_button():
	get_tree().change_scene("res://scenes/Main.tscn")
	hard_reset()
