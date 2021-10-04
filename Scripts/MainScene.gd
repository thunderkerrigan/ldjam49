extends Node

signal gameOver

export (Array, PackedScene) var MiniGames
var nextIndex :int = -1
var currentGame = null

var gamesForCurrentLoop = []

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var life = 3
var victoryCount = 0

var story_mode = true

var difficulty_level = 0
var duration_level = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug('_ready')
	gamesForCurrentLoop = MiniGames.duplicate()
	$StartTimer.start()
	$Interlude.show()
	if story_mode:
		$InfinityLayer/InfinityTable.show()
		$InfinityTween.interpolate_property($InfinityLayer/InfinityTable, 'rect_scale', Vector2(1.1,1.1), Vector2.ONE, 0.4,Tween.TRANS_ELASTIC & Tween.TRANS_BACK, Tween.EASE_IN_OUT)		
		$InfinityTween.start()
	else:
		$InfinityLayer/InfinityTable.hide()
		
	
	
func start_game():
	life = 3 
	victoryCount = 0	
	$StartTimer.start()

func shakeLifePoint():
	$RemainingLifeTween.interpolate_property($Interlude/Control/HeartBoxContainer2, "rect_scale",
		Vector2(2.5, 2.5), Vector2.ONE, 0.4, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$RemainingLifeTween.start()

func resetInterlude():
	$Interlude.show()
	$InfinityLayer/InfinityTable.show()	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$StartTimer.start()
	if currentGame != null:
		currentGame.disconnect('win', self, 'didWin')
		currentGame.disconnect('lose', self, 'didLose')
		currentGame.queue_free()

func didWin():
	resetInterlude()
	
	$VictoryOrDefeatSoundEffect.play_victory()	
	victoryCount +=1
	$InfinityLayer/InfinityTable.showNumber = victoryCount
	$InfinityLayer/InfinityTable.tryShowInfinity()
	if !story_mode:
		difficulty_level = min(floor(victoryCount / 3),5)
		duration_level = max(duration_level -0.1* difficulty_level, 3)
	else:
		gamesForCurrentLoop.remove(nextIndex)
		
	

func didLose():
	resetInterlude()
	$VictoryOrDefeatSoundEffect.play_defeat()
	if life > 1: # still enough heart
		life -= 1
		$Interlude/Control/HeartBoxContainer2.update_health(life)
		shakeLifePoint()
	else:
		if !story_mode:
			emit_signal("gameOver", victoryCount * 100000)
		else:
			emit_signal("gameOver", 0)
	
	
func _on_StartTimer_timeout():
	$Interlude.hide()
	$InfinityLayer/InfinityTable.hide()
	print_debug('time: ', duration_level)
	if gamesForCurrentLoop.size() == 0:
		print_debug('NO MORE GAME!')
		emit_signal("gameOver", 0)
		return #TODO: winning panel
	nextIndex = randi() % gamesForCurrentLoop.size()
	var nextGameType = gamesForCurrentLoop[nextIndex]
	var nextGame = nextGameType.instance()
	add_child(nextGame)
	currentGame = nextGame
	currentGame.connect('win', self, 'didWin')
	currentGame.connect('lose', self, 'didLose')
	if currentGame.has_method('set_difficulty'):
		currentGame.set_difficulty(duration_level, difficulty_level)
