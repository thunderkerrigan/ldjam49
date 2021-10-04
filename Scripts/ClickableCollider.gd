
extends Area2D


export var soundClip: PackedScene = preload("res://Scenes/SoundEffect.tscn")
export var audioClip: AudioStream = preload("res://Assets/Sounds/hit-someting-6037.mp3")

signal clicked

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	print("Click")
	var newSound = soundClip.instance()
	add_child(newSound)
	newSound.pitch_scale = rand_range(0.6, 1.7)
	newSound.start(audioClip)
	emit_signal("clicked")
