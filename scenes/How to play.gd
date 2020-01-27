extends MarginContainer

signal clicked

func _ready():
	connect("clicked", _global, "how_to_play_button")

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.pressed:
		emit_signal("clicked")
		
		$"../../../".visible = false
		$"../../../../How to play".visible = true
		
		accept_event()
