extends ScrollContainer
@onready var musicVolume = %MusicVolume
@onready var sfxVolume = %SFXVolume
@onready var togFullscreen = %ToggleFullscreen
@onready var skipCutscenes = %SkipCutscenes
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

var user_prefs: UserPreferences

func _ready():
	user_prefs = UserPreferences.load_or_create()
	if sfxVolume:
		sfxVolume.value = user_prefs.sfx_audio_level
	if musicVolume:
		musicVolume.value = user_prefs.music_audio_level
	if togFullscreen:
		togFullscreen.button_pressed = user_prefs.togFullscreen
	if skipCutscenes:
		skipCutscenes.button_pressed = user_prefs.skipCS

func _on_music_volume_value_changed(value):
	if user_prefs:
		user_prefs.music_audio_level = value
		user_prefs.save()
		AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
		AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)

func _on_sfx_volume_value_changed(value):
	if user_prefs:
		user_prefs.sfx_audio_level = value
		user_prefs.save()
		AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
		AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)

func _on_toggle_fullscreen_toggled(toggled_on):
	if toggled_on == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if user_prefs:
		user_prefs.togFullscreen = toggled_on
		user_prefs.save()
