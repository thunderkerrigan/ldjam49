extends Node

var defeat_sound1: AudioStream = preload("res://Assets/Sounds/Defeat/boowav-6377(1).mp3")
var defeat_sound2: AudioStream = preload("res://Assets/Sounds/Defeat/wah-wah-sad-trombonewav-6347.mp3")
var defeat_sound3: AudioStream = preload("res://Assets/Sounds/Defeat/smashing-glasswav-6166.mp3")

var defeats = [defeat_sound1, defeat_sound2, defeat_sound3]

var victory_sound1: AudioStream = preload("res://Assets/Sounds/Victory/yaymp3-6326.mp3")
var victory_sound2: AudioStream = preload("res://Assets/Sounds/Victory/applause.mp3")
var victory_sound3: AudioStream = preload("res://Assets/Sounds/Victory/cheer.wav")


var victories = [victory_sound1, victory_sound2, victory_sound3]

var SoundEffect: PackedScene = preload("res://Scenes/SoundEffect.tscn")

func play_victory():
	var sound = victories[randi() % victories.size()]
	var speed = sound.get_length()*.5
	var soundEffect = SoundEffect.instance()
	add_child(soundEffect)
	soundEffect.pitch_scale = speed
	soundEffect.start(sound)
	
func play_defeat():
	var sound = defeats[randi() % defeats.size()]
	var speed = sound.get_length()*.5
	var soundEffect = SoundEffect.instance()
	add_child(soundEffect)
	soundEffect.pitch_scale = speed
	soundEffect.start(sound)

