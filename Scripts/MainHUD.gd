extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 700
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
func _process(delta):
	$Path2D/PathFollow2D.offset = randi()
	velocity = $MainTitle.rect_position.direction_to($Path2D/PathFollow2D.offset) * speed
	# look_at(target)
	if $MainTitle.rect_position.distance_to($Path2D/PathFollow2D.offset) > 5:
		$MainTitle.velocity = $MainTitle.move_and_slide($MainTitle.velocity)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
