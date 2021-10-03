extends Node

signal win
signal lose

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ErlenMeyer/AnimationPlayer.play("shake")
	change_pipette_position()
	$Music.play()

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
		emit_signal('win')
		$MiniGameCountdownTimer.stop()
		$Music.stop()

func _on_MiniGameCountdownTimer_countownElapsed():
	emit_signal('lose')
	$Music.stop()	
