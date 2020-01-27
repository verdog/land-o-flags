extends Node2D

signal reset

func _ready():
	connect("reset", _global, "window_reset")

func _unhandled_input(event):
    # quit on escape
	if event is InputEventKey:
        if event.pressed and event.scancode == KEY_ESCAPE:
            get_tree().quit()

	# restart on f1
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_F1:
			emit_signal("reset")
