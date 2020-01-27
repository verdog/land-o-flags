extends RichTextLabel

var string = " Islands claimed: %s"

func _ready():
	_global.connect("state_changed", self, "state_changed")
	update_text()

func _on_Chunk_Win_win():
	update_text()

func update_text():
	text = string % _global.islands_claimed
	
func state_changed():
	var state = _global._gamestate
	if state == _global.STATE.LOSE:
		$"../..".visible = false # Status
	if state == _global.STATE.CLIMB:
		$"../..".visible = true
