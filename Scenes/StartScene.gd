extends Control

export (PackedScene) var Game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var highScore = 'highScore: 0'
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
	_game.queue_free()
	$Music.play()	
	$MarginContainer/VBoxContainer/EndlessButton.disabled = false
	if score > 0:
		$MarginContainer/VBoxContainer/Label.show()	


func start():
	_game = Game.instance()
	$Music.stop()
	add_child(_game)
	_game.connect('gameOver', self, 'gameOver')
