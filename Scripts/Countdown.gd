extends Container

export (int) var seconds = 0



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	$Label.set_text(str(seconds))



func _on_CountdownTimer_timeout():
	if seconds >= 1:
		seconds -= 1
	else:
		seconds = 0
		
	
