extends Node2D

signal countownElapsed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	start(3)

func reset():
	$Control/DropAnimationPlayer.stop()
	$Control/CountdownTimer.stop()

func start(time):
	$Control/DropAnimationPlayer.stop()	
	$Control/CountdownTimer.start(time)
	var randomBomb = randi() % 10
	if randomBomb > 5:
		$Control/little_boy.hide()
		$Control/fat_man.show()
	else:
		$Control/little_boy.show()
		$Control/fat_man.hide()
	$Control/DropAnimationPlayer.play("Drop",-1, 3.0/time)

func stop():
	$Control/CountdownTimer.stop()
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DropAnimationPlayer_animation_finished(anim_name):
	emit_signal("countownElapsed")
