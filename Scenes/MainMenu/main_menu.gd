extends Control
@onready var menu_music = $MenuMusic

func _ready():
	menu_music.play()

func _on_play_btn_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Loadout/loadout.tscn")

func _on_exit_btn_pressed():
	get_tree().quit()

func _on_option_s_btn_toggled(toggled_on):
	if toggled_on == true:
		$OptionsMenu.show()
	elif toggled_on == false:
		$OptionsMenu.hide()
