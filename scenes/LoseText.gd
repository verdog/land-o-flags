extends RichTextLabel

var string = """ You lost your only flag...
 But you claimed %s %s!
 %s"""

func _ready():
	_global.connect("state_changed", self, "state_changed")
	
func state_changed():
	var state = _global._gamestate
	if state == _global.STATE.LOSE:
		$"../../".visible = true # Lose container
		
		var islandword
		if _global.islands_claimed == 1:
			islandword = "island"
		else:
			islandword = "islands"
		text = string % [_global.islands_claimed, islandword, get_cool_word()]
	else:
		$"../../".visible = false

func get_cool_word():
	var claimed = _global.islands_claimed
	
	if claimed < 1:
		return "You could do better..."
	elif claimed < 2:
		return "You got one!"
	elif claimed < 5:
		return "Not bad!"
	elif claimed < 10:
		return "Great job!"
	elif claimed < 20:
		return "Amazing!"
	else:
		return "Legendary!"
