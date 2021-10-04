extends Control


func _ready():
	$Tween.interpolate_property($Control, "rect_rotation",
		-360, 360, 5.2, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	$TweenText.interpolate_property($FirstText, "rect_scale",
	Vector2(2.5, 2.5), Vector2.ONE, 0.5, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$TweenText.start()
	$TweenText2.interpolate_property($SecondText, "rect_scale",
	Vector2(2.5, 2.5), Vector2.ONE, 0.8, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$TweenText2.start()
	
