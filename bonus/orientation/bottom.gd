extends Bonus

func set_sprite():
	$Bonus/Sprite2D.set_texture(load("res://art/orientation_bonus.png"))

func effect():
	get_parent().get_parent().bottom()
