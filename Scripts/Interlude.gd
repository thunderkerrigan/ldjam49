extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show():
	$Control.show()
	$Control/AudioStreamPlayer2D.play()

func hide():
	$Control.hide()
	$Control/AudioStreamPlayer2D.stop()

func _on_BackgroundColorTimer_timeout():
	$Control/BackgroundColor.color = Color(randf(), randf(), randf())
