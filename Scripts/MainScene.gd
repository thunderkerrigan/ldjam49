extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var life = 3
var victoryCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_game():
	life = 3 
	victoryCount = 0



func _on_MinusButton_pressed():
	if life > 0:
		life -= 1
		print_debug('_on_MinusButton_pressed', life)
		$Interlude/HeartBoxContainer2.update_health(life)
	

func _on_PlusButton_pressed():
	if life < 3:
		life += 1
		print_debug('_on_PlusButton_pressed', life)
		$Interlude/HeartBoxContainer2.update_health(life)
