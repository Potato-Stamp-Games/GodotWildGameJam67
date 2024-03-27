extends Control

var currentLevel = Global.currentLevel
@onready var pause_menu_sfx = $PauseMenuSfx
const MENU_CONFIRM = preload("res://Assets/SoundDesign/MenuConfirm.wav")
const MENU_DENY = preload("res://Assets/SoundDesign/MenuDeny.wav")

func _on_restart_button_pressed():
	Engine.time_scale = 1
	pause_menu_sfx.stream = MENU_CONFIRM
	pause_menu_sfx.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file(currentLevel)
	
	

func _on_loadout_button_pressed():
	Engine.time_scale = 1
	pause_menu_sfx.stream = MENU_CONFIRM
	pause_menu_sfx.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://Scenes/Loadout/loadout.tscn")

func _on_quit_button_pressed():
	pause_menu_sfx.stream = MENU_DENY
	pause_menu_sfx.play()
	get_tree().quit()

func _on_options_button_toggled(toggled_on):
	if toggled_on == true:
		pause_menu_sfx.stream = MENU_CONFIRM
		$OptionsMenu.show()
	elif toggled_on == false:
		pause_menu_sfx.stream = MENU_DENY
		$OptionsMenu.hide()
		
	pause_menu_sfx.play()
		

