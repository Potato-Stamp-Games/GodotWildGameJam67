extends Control

var currentLevel = Global.currentLevel

func _on_restart_button_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file(currentLevel)

func _on_loadout_button_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/Loadout/loadout.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_options_button_toggled(toggled_on):
	if toggled_on == true:
		$OptionsMenu.show()
	elif toggled_on == false:
		$OptionsMenu.hide()

