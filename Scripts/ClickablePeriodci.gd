
extends Area2D

signal periodicClicked

export var soundClip: PackedScene = preload("res://Scenes/SoundEffect.tscn")
export var audioClip: AudioStream = preload("res://Assets/Sounds/hit-someting-6037.mp3")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	print("ClickPeriodic")
	var newSound = soundClip.instance()
	add_child(newSound)
	newSound.pitch_scale = rand_range(0.6, 1.7)
	newSound.start(audioClip)
	#$Node2D._onButtonPressed()
	emit_signal("periodicClicked")
