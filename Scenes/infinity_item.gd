extends TextureRect

export (Texture) var showTexture  
export (Texture) var hideTexture



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hideInfinity()
	
func showInfinity():
	texture = showTexture
	
func hideInfinity():
	texture = hideTexture
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
