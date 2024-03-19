extends Control

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _on_loadout_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Loadout/loadout.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_options_button_toggled(toggled_on):
	if toggled_on == true:
		$OptionsMenu.show()
	elif toggled_on == false:
		$OptionsMenu.hide()

