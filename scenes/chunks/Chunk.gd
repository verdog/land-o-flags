extends "res://scenes/Chunk_Base.gd"

var flagtype = preload("res://scenes/Flag.gd")

signal lose

func _ready():
	connect("lose", _global, "lose")

func _on_Lose_Area_body_entered(body):
	if body is flagtype and _global._gamestate != _global.STATE.LOSE:
		if body.state == "bounce":
			emit_signal("lose")
