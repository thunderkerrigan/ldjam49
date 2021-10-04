extends Node

signal win
signal lose

var goodEnding = preload("res://Scenes/MiniGame/Chimie/good_ending.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MiniGameCountdownTimer/Control/CountdownTimer.stop()
	$MiniGameCountdownTimer/Control/DropAnimationPlayer.stop()

func change_pipette_position():
	$PipettePath2D/PathFollow2D.offset = randi()
	var direction = $PipettePath2D/PathFollow2D.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	$Pipettes.position = $PipettePath2D/PathFollow2D.position
	$Pipettes.rotation = direction
	
func _on_Pipettes_touched():
	$ErlenMeyer/Control/ErlenmeyerProgress.value += 20
	change_pipette_position()
	if $ErlenMeyer/Control/ErlenmeyerProgress.value == 100:
		victory()
		
func victory():
	$MiniGameCountdownTimer.stop()
	var ending = goodEnding.instance()
	add_child(ending)
	yield(get_tree().create_timer(1.5), "timeout")
	ending.queue_free()
	$Music.stop()		
	emit_signal('win')
	

func _on_MiniGameCountdownTimer_countownElapsed():
	emit_signal('lose')
	$Music.stop()	


func _on_Node2D_ended():
	$MiniGameCountdownTimer.start(3)
	$ErlenMeyer/AnimationPlayer.play("shake")
	change_pipette_position()
	$Music.play()
