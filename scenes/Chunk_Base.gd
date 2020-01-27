extends Node2D

export var chunk_name = "Chunk_Base"

func _ready():
	initialize()

func initialize():
	# initializes the chunk in whatever way it might need
	print("initializing chunk: " + chunk_name)
