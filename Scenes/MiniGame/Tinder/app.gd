extends Control

signal lose
signal win

export var card: PackedScene = preload("res://Scenes/MiniGame/Tinder/card.tscn")
export var match_scene: PackedScene = preload("res://Scenes/MiniGame/Tinder/matchScreen.tscn")

var next_card = null
var successCount = 5
func _ready():
	randomize()
	$MusicPlayer.play()
	$CardContainer/Card.enabled = true

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
	
	if isTable == false:
		game_over()
	else:
		successCount -= 1
		if successCount == 0:
						game_win()
	
func game_over():
	$MusicPlayer.stop()	
	emit_signal('lose')
	
	
func game_win():
	$MusicPlayer.stop()	
	emit_signal('win')
	
func on_card_disliked(isTable):
	print_debug('on_card_disliked isTable ', isTable)
	if isTable == true:
		game_over()
	else:
		successCount -= 1
		if successCount == 0:
			game_win()
	
func on_keep_swiping():
	print_debug('on_keep_swiping')
	$MatchContainer.get_child(0).call_deferred("queue_free")
