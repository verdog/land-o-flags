extends MarginContainer

signal clicked

func _ready():
	connect("clicked", _global, "start_button")

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.pressed:
		emit_signal("clicked")
		accept_event()
