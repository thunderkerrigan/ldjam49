
extends Area2D

signal periodicClicked

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	print("ClickPeriodic")
	#$Node2D._onButtonPressed()
	emit_signal("periodicClicked")