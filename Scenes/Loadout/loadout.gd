extends Control
var weaponPressed = false
var atTexture: Texture = load("res://Assets/Tiles/Pickuptileset.png")
var weaponAtlas: AtlasTexture
var modifier1Atlas: AtlasTexture
var modifier2Atlas: AtlasTexture

#Sound
@onready var gui_sfx = $GuiSfx
const MENU_CONFIRM = preload("res://Assets/SoundDesign/MenuConfirm.wav")
const MENU_DENY = preload("res://Assets/SoundDesign/MenuDeny.wav")


func _ready():
	get_tree().paused = false
	weaponAtlas = AtlasTexture.new()
	modifier1Atlas = AtlasTexture.new()
	modifier2Atlas = AtlasTexture.new()
	weaponAtlas.atlas = atTexture
	modifier1Atlas.atlas = atTexture
	modifier2Atlas.atlas = atTexture

func resetPressed():
	Global.mod1Pressed = false
	Global.mod2Pressed = false
	weaponPressed = false
	%Modifier1.self_modulate = "ffffff"
	%Modifier2.self_modulate = "ffffff"
	%WeaponSlot1.self_modulate = "ffffff"
func are_elements_unequiped():
	if Global.poisonEquiped == false and Global.iceEquiped == false and Global.fireEquiped == false:
		return true
func are_modifiers2_unequiped():
	if Global.speedEquiped == false and Global.damageEquiped == false and Global.attackSEquiped == false:
		return true

func _on_weapon_equiped_pressed():
	if weaponPressed == false:
		resetPressed()
		%WeaponEquip.show()
		%ModEquip2.hide()
		%ModEquip1.hide()
		%WeaponSlot1.self_modulate = "001bc7"
		weaponPressed = true
	else :
		%WeaponEquip.hide()
		%ModEquip1.hide()
		%ModEquip2.hide()
		weaponPressed = false
func _on_modifier_1_pressed():
	if Global.mod1Pressed == false:
		resetPressed()
		%ModEquip1.show()
		%ModEquip2.hide()
		%WeaponEquip.hide()
		%Modifier1.self_modulate = "001bc7"
		Global.mod1Pressed = true
	else:
		%ModEquip2.hide()
		%ModEquip1.hide()
		%WeaponEquip.hide()
		Global.mod1Pressed = false
func _on_modifier_2_pressed():
	if Global.mod2Pressed == false:
		resetPressed()
		%ModEquip2.show()
		%ModEquip1.hide()
		%WeaponEquip.hide()
		%Modifier2.self_modulate = "001bc7"
		Global.mod2Pressed = true
	else:
		%ModEquip2.hide()
		%ModEquip1.hide()
		%WeaponEquip.hide()
		Global.mod2Pressed = false
#SCENE BUTTONS
func _on_exit_btn_pressed():
	gui_sfx.stream = MENU_CONFIRM
	gui_sfx.play()
	await get_tree().create_timer(0.15)
	get_tree().quit()
func _on_play_btn_pressed():
	gui_sfx.stream = MENU_CONFIRM
	gui_sfx.play()
	await get_tree().create_timer(0.15)
	get_tree().change_scene_to_file("res://Scenes/Levels/baseLevel.tscn")
func _on_research_btn_pressed():
	gui_sfx.stream = MENU_CONFIRM
	gui_sfx.play()
	await get_tree().create_timer(0.15)
	get_tree().change_scene_to_file("res://Scenes/Loadout/research.tscn")

func _on_work_toolbench_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	$MainBackground/DriversLicense.show()
func _on_work_toolbench_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	$MainBackground/DriversLicense.hide()
	%WeaponEquip.hide()
	%ModEquip1.hide()
	%ModEquip2.hide()

var rsHover = false
func _on_work_research_table_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	rsHover = true
	$ResearchBtn.show()
func _on_work_research_table_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	$ResearchBtn.hide()
	%RsAnimate.stop()
	rsHover = false

func _on_settings_btn_toggled(toggled_on):
	if toggled_on == true:
		gui_sfx.stream = MENU_CONFIRM
		gui_sfx.play()
		await get_tree().create_timer(0.15)
		$OptionsMenu.show()
	elif toggled_on == false:
		gui_sfx.stream = MENU_DENY
		gui_sfx.play()
		await get_tree().create_timer(0.13)
		$OptionsMenu.hide()

func _process(_delta):
	#Animation
	if rsHover == true:
		%RsAnimate.play("rotate-loop")
	#WEAPONS
	if Global.nailgunEquiped == true:
		weaponAtlas.region = Rect2(0, 0, 32, 32)
		%EquipedWeapon.texture = weaponAtlas
	elif Global.crowbarEquiped == true:
		weaponAtlas.region = Rect2(32, 32, 32, 32)
		%EquipedWeapon.texture = weaponAtlas
	elif Global.tapeMeasureEquiped == true:
		weaponAtlas.region = Rect2(64, 32, 32, 32)
		%EquipedWeapon.texture = weaponAtlas
	elif Global.sixPackEquiped == true:
		weaponAtlas.region = Rect2(0, 64, 32, 32)
		%EquipedWeapon.texture = weaponAtlas
	else:
		weaponAtlas.region = Rect2(0, 0, 0, 0)
		%EquipedWeapon.texture = weaponAtlas
		
	if Global.poisonEquiped == true:
		modifier1Atlas.region = Rect2(96, 96, 32, 32)
		%EquipedMod1.texture = modifier1Atlas
	elif Global.iceEquiped == true:
		modifier1Atlas.region = Rect2(32, 96, 32, 32)
		%EquipedMod1.texture = modifier1Atlas
	elif Global.fireEquiped == true:
		modifier1Atlas.region = Rect2(64, 96, 32, 32)
		%EquipedMod1.texture = modifier1Atlas
	if are_elements_unequiped() == true:
		modifier1Atlas.region = Rect2(0, 0, 0, 0)
		%EquipedMod1.texture = modifier1Atlas
	
	if Global.speedEquiped == true:
		modifier2Atlas.region = Rect2(0, 32, 32, 32)
		%EquipedMod2.texture = modifier2Atlas
	elif Global.damageEquiped == true:
		modifier2Atlas.region = Rect2(64, 0, 32, 32)
		%EquipedMod2.texture = modifier2Atlas
	elif Global.attackSEquiped == true:
		modifier2Atlas.region = Rect2(96, 0, 32, 32)
		%EquipedMod2.texture = modifier2Atlas
	if are_modifiers2_unequiped() == true:
		modifier2Atlas.region = Rect2(0, 0, 0, 0)
		%EquipedMod2.texture = modifier2Atlas


