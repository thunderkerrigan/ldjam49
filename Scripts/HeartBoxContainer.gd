extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tick = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_health(value):
	print_debug('update_health', value)
	for i in get_child_count():
		get_child(i).visible = value > i
