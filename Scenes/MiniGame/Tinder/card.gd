extends Control


signal moving()
signal finished()
signal like(card, image)
signal dislike(card)

var TinderProfile = load("res://Scripts/TinderProfile.gd")

export (Array, Texture) var profilePictures 
export (Array, String) var profileNames
export (Array, String) var profileDescriptions
export (Array, bool) var isTables 


var currentIndex = 0

var pressed = false
var first_press_pos = null
var latest_speed = Vector2.ZERO

var nope_like_visible_dist = 450

var enabled = false

func _ready():
	print_debug("NEW")
	randomize()
	currentIndex = int(rand_range(0, profilePictures.size()))
	# Choose random image set
	
	change_image(currentIndex)
	
	## Choose random name
	$MarginContainer/HBoxContainer/VBoxContainer/Name.text = profileNames[currentIndex]
	$MarginContainer/HBoxContainer/VBoxContainer/Description.text = profileDescriptions[currentIndex]
	
	$ImageContainer/Image.material.set_shader_param("size", $ImageContainer/Image.rect_size)
	
func _input(event):
	if !enabled: return
	
	if event is InputEventScreenDrag:
		var dist = event.position - first_press_pos
		emit_signal("moving")
		rect_position = dist
		rect_rotation = -(event.position.x - first_press_pos.x) * 0.025
		if sign(dist.x) > 0: 
			$Like.modulate = lerp(Color("#00ffffff"), Color("#ffffffff"), 
				abs(dist.x)/nope_like_visible_dist)
		else:
			$Nope.modulate = lerp(Color("#00ffffff"), Color("#ffffffff"), 
				abs(dist.x)/nope_like_visible_dist)
		pressed = false
		latest_speed = event.speed
	
	if  event is InputEventMouseMotion && event.pressure > 0:
		
		var dist = event.position - first_press_pos
		print_debug("moving")
		emit_signal("moving")
		rect_position = dist
		rect_rotation = -(event.position.x - first_press_pos.x) * 0.025
		if sign(dist.x) > 0: 
			$Like.modulate = lerp(Color("#00ffffff"), Color("#ffffffff"), 
				abs(dist.x)/nope_like_visible_dist)
		else:
			$Nope.modulate = lerp(Color("#00ffffff"), Color("#ffffffff"), 
				abs(dist.x)/nope_like_visible_dist)
		pressed = false
		latest_speed = event.speed
		
	if event is InputEventMouseButton:
		
		if event.pressed:
			pressed = true
			first_press_pos = event.position
		else:
			if pressed:
				if event.position.x > (rect_size.x/2):
					_on_NextBtn_pressed()
				else:
					_on_PreviousBtn_pressed()
			else:
				pressed = false
				
				first_press_pos = null
				if abs(latest_speed.x) > 1000:
					# remove card
					rect_position += latest_speed
					emit_signal("finished")
					
					if sign(latest_speed.x) > 0:
						emit_signal("like", isTables[currentIndex])
					else:
						emit_signal("dislike", isTables[currentIndex])
					queue_free()
				else:
					rect_position = Vector2.ZERO
					rect_rotation = 0
					$Like.modulate = Color("#00ffffff")
					$Nope.modulate = Color("#00ffffff")
	
	
func change_image(idx):
	$ImageContainer/Image.texture = profilePictures[idx]

func _on_PreviousBtn_pressed():
	pass

func _on_NextBtn_pressed():
	pass

func _on_Card_gui_input(event):
	#print(event)
	pass

func _on_Button_pressed():
	pass # Replace with function body.
