extends Node2D

onready var timer = get_node("Timer")


func _ready():
	timer.set_wait_time(3)
	timer.start()
	print("start pause")
	get_tree().paused = true


func _on_Timer_timeout():
	print("Fin de pause")
	get_tree().paused = false
	hide()

