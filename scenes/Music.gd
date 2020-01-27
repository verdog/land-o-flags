extends Node2D

onready var musicq = [ $"./Bg1", $"./Bg2" ]

var pointer = 0

func change_bgm():
	stop_bgm()
	musicq[pointer].play()
	pointer = (pointer + 1) % len(musicq)

func stop_bgm():
	if $"./Title".playing == true:
		$"./Title".stop()
	if $"./Bg1".playing == true:
		$"./Bg1".stop()
	if $"./Bg2".playing == true:
		$"./Bg2".stop()
	if $"./Win".playing == true:
		$"./Win".stop()
