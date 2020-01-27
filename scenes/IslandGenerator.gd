extends Node2D

onready var chunk_bank = load_chunks()

func _ready():
	generate_island()
	
func load_chunks():
	var dir = Directory.new()
	var array = []
	
	var directory_path = "res://scenes/chunks/random"
	
	if dir.open(directory_path) == OK:
	    dir.list_dir_begin()
	    var filename = dir.get_next()
	    while filename != "":
	        if not dir.current_is_dir():
	            var path = directory_path + "/" + filename
	            array.append(load(path))
	
	        filename = dir.get_next()
	
	return array

func generate_island():
	var last = $"./Chunk_Start"
	
	var generated = 0
	
	while generated < _global.island_length:
		if generated % len(chunk_bank) == 0:
			chunk_bank.shuffle()
		
		var chunk = chunk_bank[generated % len(chunk_bank)].instance()
		chunk.position = last.get_node("Anchor/Exit").global_position
		add_child(chunk)
		last = chunk
		generated += 1
		
	# put win podium up
	var win = $"./Chunk_Win"
	win.position = last.get_node("Anchor/Exit").global_position
	
	# put water tiles in
	var tilemap = $"./Chunk_Start/Foreground"
	var end = $"./Chunk_Win/Anchor/Exit"
	for i in range(-32, (end.global_position.x/16) + 32):
		# block
		for j in range(0, 32):
			tilemap.set_cell(i, 2+j, 18)
		# top
		if i%2 == 0:
			tilemap.set_cell(i, 1, 17)
		else:
			tilemap.set_cell(i, 1, 23)
