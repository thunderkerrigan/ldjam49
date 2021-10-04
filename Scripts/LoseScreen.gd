extends Node2D

onready var timer = get_node("Timer")


func _on_Timer_timeout():
	print("Fin de pause")
	get_tree().paused = false
	hide()


func _on_Clickable_clicked():
	show()
	timer.set_wait_time(3)
	timer.start()
	print("start pause")
	get_tree().paused = true
	
	
	
