extends Node
export (PackedScene) var Mob

signal lose
signal win

var match_scene = preload("res://Scenes/MiniGame/radioactif/win_nuclear.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _win():
	$MobTimer.stop()
	get_tree().call_group("mobs", "queue_free")
	var matching = match_scene.instance()
	add_child(matching)
	yield(get_tree().create_timer(1.5), "timeout")
	matching.queue_free()
	$Music.stop()
	emit_signal("win")

func _game_over():
	$MobTimer.stop()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	emit_signal("lose")

	
func new_game():
	$Player.start($StartPosition.position)
	$EndTimer.start()
	$Music.play()
	$MobTimer.start()


func _on_EndTimer_timeout():
	_win()


func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
