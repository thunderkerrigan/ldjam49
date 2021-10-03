extends Area2D

signal touched

export var soundClip: PackedScene = preload("res://Scenes/SoundEffect.tscn")
export var audioClip: AudioStream = preload("res://Assets/Sounds/cartoon-jumpwav-6462.mp3")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	var newSound = soundClip.instance()
	add_child(newSound)
	newSound.pitch_scale = rand_range(0.6, 1.7)
	newSound.start(audioClip)
	emit_signal("touched")

func _input(event):
	pass
	#if event is InputEventMouseButton:
		#if event.pressed:
			#if Rect2(position, texture.get_size()*Vector2(0.20,0.20)).has_point(event.position):
			#	var newSound = soundClip.instance()
			#	add_child(newSound)
			#	newSound.pitch_scale = rand_range(0.6, 1.7)
			#	newSound.start(audioClip)
			#	emit_signal("touched")
