extends Control


func _ready():
	$Tween.interpolate_property($VBoxContainer/HBoxContainer/Text, "rect_scale",
		Vector2(4.5, 4.5), Vector2.ONE, 0.8, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
