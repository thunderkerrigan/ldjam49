extends Control

signal lose
signal win

export var card: PackedScene = preload("res://Scenes/MiniGame/Tinder/card.tscn")
export var match_scene: PackedScene = preload("res://Scenes/MiniGame/Tinder/matchScreen.tscn")
export var soundClip: PackedScene = preload("res://Scenes/SoundEffect.tscn")
export (Array, AudioStream) var kissSounds

var game_duration: float = 3
var game_difficulty: int = 0

func set_difficulty(duration, level):
	game_duration = duration
	game_difficulty =  level

var next_card = null
var successCount = 3
func _ready():
		$MiniGameCountdownTimer.reset()

func _on_Card_moving():
	if $CardContainer.get_child_count() != 1: return
	var instance = card.instance()
	$CardContainer.add_child(instance)
	$CardContainer.move_child(instance, 0)
	next_card = instance
	instance.connect("moving", self, "_on_Card_moving")
	instance.connect("finished", self, "_on_Card_finished")
	instance.connect("like", self, "on_card_liked")
	instance.connect("dislike", self, "on_card_disliked")

func _on_Card_finished():
	print_debug('_on_Card_finished')
	next_card.enabled = true

func on_card_liked(isTable):
	print_debug('on_card_liked isTable ', isTable)
	playSoundKiss()
	if isTable == false:
		game_over()
	else:
		successCount -= 1
		if successCount == 0:
						game_win()
	
func game_over():
	$MiniGameCountdownTimer.stop()	
	$MusicPlayer.stop()	
	emit_signal('lose')
	
	
func game_win():
	$MiniGameCountdownTimer.stop()
	var matching = match_scene.instance()
	add_child(matching)
	yield(get_tree().create_timer(1.5), "timeout")
	matching.queue_free()
	$MusicPlayer.stop()		
	emit_signal('win')
	
func playSoundKiss():
	var kissType = kissSounds[randi() % kissSounds.size()]
	var kiss = soundClip.instance()
	add_child(kiss)
	kiss.start(kissType)
	
func on_card_disliked(isTable):
	print_debug('on_card_disliked isTable ', isTable)
	playSoundKiss()
	if isTable == true:
		game_over()
	else:
		successCount -= 1
		if successCount == 0:
			game_win()
	
func on_keep_swiping():
	print_debug('on_keep_swiping')
	$MatchContainer.get_child(0).call_deferred("queue_free")

func _on_MiniGameCountdownTimer_countownElapsed():
	game_over()


func _on_swipe_objective_ended():
	randomize()
	$MusicPlayer.play()
	$MiniGameCountdownTimer.start(4)
	$CardContainer/Card.enabled = true
	successCount += floor(game_difficulty/2) +(game_difficulty %2)
	print_debug('success count: ', successCount)
