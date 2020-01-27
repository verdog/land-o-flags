extends Sprite

onready var flag = $"../../Flag"
onready var player = $".."

func _process(delta):
	if flag:
		if flag.state == "bounce" and (flag.position - player.position).length() > 64:
			visible = true
			var dir = player.position.angle_to_point(flag.position)
			rotation = dir + PI
		else:
			visible = false
