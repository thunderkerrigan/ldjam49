extends Node2D

signal ended

var SoundClip = preload("res://Scenes/SoundEffect.tscn")

var clip1 = preload("res://Assets/Sounds/Start/game-start-6104.mp3")
var clip2 = preload("res://Assets/Sounds/Start/level-winwav-6416.mp3")
var clip3 = preload("res://Assets/Sounds/Start/boingwav-6222.mp3")
var clip4 = preload("res://Assets/Sounds/Start/chime-sound-7143.mp3")
var clip5 = preload("res://Assets/Sounds/Start/success-1-6297.mp3")
var clips = [clip1, clip2, clip3, clip4, clip5]

func start():
	randomize()
	var clip = clips[randi() % clips.size()]
	var audio = SoundClip.instance()
	add_child(audio)
	if clip.get_length() > 1.5:
		audio.pitch_scale = clip.get_length()/1.8	
	audio.start(clip)
	$Timer.start(1.5)

func _ready():
	start()

func _on_Timer_timeout():
	print("Fin de pause")
	emit_signal("ended")
	hide()

