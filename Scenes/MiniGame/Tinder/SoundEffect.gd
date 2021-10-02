extends AudioStreamPlayer

func start(sound: AudioStream):
	set_stream(sound)
	play()
	$Timer.start(stream.get_length())
	
func _on_Timer_timeout():
	stop()
	queue_free()
