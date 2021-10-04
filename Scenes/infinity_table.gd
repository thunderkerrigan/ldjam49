extends Control

var showNumber:int = -1

func tryShowInfinity():
	var count = get_child_count()
	for i in count:
		var texture = get_child(i).get_child(0)
		if i< showNumber:
			texture.showInfinity()		
		else:
			texture.hideInfinity()
		
