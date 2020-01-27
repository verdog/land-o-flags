extends Node2D

onready var points = $"./Spawn_Points".get_children()

var rocktype = preload("res://scenes/enemies/Enemy_Rock.gd")

func _ready():
	spawn_enemies()
	
func spawn_enemies():
	for sp in points:
		var enemy = generate_enemy()
		
		if enemy != null:
			$"./Enemies".add_child(enemy)
			if enemy is rocktype:
				enemy.global_position = sp.global_position - Vector2(0, 180)
			else:
				enemy.global_position = sp.global_position

func generate_enemy():
	var enemy = _global.enemy_bank[floor(rand_range(0, len(_global.enemy_bank)))]
	
	if enemy != null:
		return enemy.instance()
	else:
		return null
