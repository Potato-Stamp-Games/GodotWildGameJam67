extends Control
@onready var menu_music = $MenuMusic
@onready var main_menu_sfx = $MainMenuSfx
const MENU_CONFIRM = preload("res://Assets/SoundDesign/MenuConfirm.wav")
const MENU_DENY = preload("res://Assets/SoundDesign/MenuDeny.wav")
func _ready():
	menu_music.play()

func _on_play_btn_pressed():
	main_menu_sfx.stream = MENU_CONFIRM
	main_menu_sfx.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Loadout/loadout.tscn")

func _on_exit_btn_pressed():
	get_tree().quit()

func _on_option_s_btn_toggled(toggled_on):
	if toggled_on == true:
		main_menu_sfx.stream = MENU_CONFIRM
		main_menu_sfx.play()
		await get_tree().create_timer(0.15).timeout
		$OptionsMenu.show()
	elif toggled_on == false:
		main_menu_sfx.stream = MENU_DENY
		main_menu_sfx.play()
		await get_tree().create_timer(0.13).timeout
		$OptionsMenu.hide()
