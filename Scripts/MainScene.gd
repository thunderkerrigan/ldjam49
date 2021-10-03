extends Node

export (Array, PackedScene) var miniGames
var currentGame = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var life = 3
var victoryCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartTimer.start()
	$Interlude.show()
	
	

func start_game():
	life = 3 
	victoryCount = 0	
	$StartTimer.start()
	



func _on_MinusButton_pressed():
	if life > 0:
		life -= 1
		print_debug('_on_MinusButton_pressed', life)
		$Interlude/Control/HeartBoxContainer2.update_health(life)

func _on_PlusButton_pressed():
	if life < 3:
		life += 1
		print_debug('_on_PlusButton_pressed', life)
		$Interlude/Control/HeartBoxContainer2.update_health(life)

func didWin():
	$Interlude.show()
	$VictoryOrDefeatSoundEffect.play_victory()	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print_debug('tes un génie rancune')
	$StartTimer.start()

func didLose():
	$Interlude.show()
	$VictoryOrDefeatSoundEffect.play_defeat()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)	
	if life > 0:
		life -= 1
		$Interlude/Control/HeartBoxContainer2.update_health(life)
	$StartTimer.start()

func _on_StartTimer_timeout():
	$Interlude.hide()
	print_debug('FIRE!!!')
	if currentGame != null:
		currentGame.disconnect('win', self, 'didWin')
		currentGame.disconnect('lose', self, 'didLose')
		currentGame.free()
	var nextGameType = miniGames[randi() % miniGames.size()]
	var nextGame = nextGameType.instance()
	add_child(nextGame)
	currentGame = nextGame
	currentGame.connect('win', self, 'didWin')
	currentGame.connect('lose', self, 'didLose')
