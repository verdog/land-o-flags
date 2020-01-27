extends Position2D

onready var base = position
onready var sprite = $"../AnimatedSprite"

func _on_AnimatedSprite_frame_changed():
	if sprite.frame == 1:
		position = base + Vector2(0, -1)
	else:
		position = base
