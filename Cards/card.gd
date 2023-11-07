extends MarginContainer


func _on_card_base_pressed():
	reparent(get_node("/root/Battle Scene/Cards in Play"))


func _on_card_base_mouse_entered():
	add_theme_constant_override("margin_left", 0)
	add_theme_constant_override("margin_right", 0)
	add_theme_constant_override("margin_top", -145)
	z_index = 1


func _on_card_base_mouse_exited():
	add_theme_constant_override("margin_left", -120)
	add_theme_constant_override("margin_right", -120)
	add_theme_constant_override("margin_top", 0)
	z_index = 0
