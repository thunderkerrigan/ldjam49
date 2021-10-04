extends Control

export (PackedScene) var Game
export (PackedScene) var intro


var introDuration = 13
var intro_has_been_displayed = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var highScore = 0
var _game
# Called when the node enters the scene tree for the first time.
func _ready():
	var endPosition = $MarginContainer.rect_position
	$Tween.interpolate_property($MarginContainer, 'rect_position', Vector2(0, -500), endPosition, 1.5, Tween.TRANS_BOUNCE, Tween.EASE_IN)
	$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func gameOver(score = 0):
	_game.disconnect('gameOver', self, 'gameOver')
	remove_child(_game)
	_game.queue_free()
	$Music.play()	
	$MarginContainer/VBoxContainer/EndlessButton.disabled = false
	if score > highScore:
		highScore = score
	if highScore > 0:
		$MarginContainer/VBoxContainer/Label.text = str('highScore: ', highScore)
		$MarginContainer/VBoxContainer/Label.show()	


func start(storyMode = true):
	_game = Game.instance()
	$Music.stop()
	add_child(_game)
	_game.story_mode = storyMode
	_game.connect('gameOver', self, 'gameOver')

func endless():
	start(false)

func story():
	if !intro_has_been_displayed:
		intro_has_been_displayed = true
		var _intro = intro.instance()
		add_child(_intro)
		yield(get_tree().create_timer(introDuration), "timeout")
		remove_child(_intro)
		_intro.queue_free()
	start(true)
