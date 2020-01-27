extends "res://scenes/Chunk_Base.gd"

var flagtype = preload("res://scenes/Flag.gd")

signal win

func _ready():
	$"./Win_Timer".connect("timeout", _global, "win_timer")

func _on_Win_Area_body_entered(body):
	if body is flagtype and _global._gamestate != _global.STATE.WIN:
		_global._gamestate = _global.STATE.WIN
		_global.islands_claimed += 1
		$"./Win_Timer".start()
		$"./Music_Timer".start()
		emit_signal("win")
		_music.stop_bgm()

func _on_Music_Timer_timeout():
	_music.get_node("./Win").play()
