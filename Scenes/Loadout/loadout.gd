extends Control
var weaponPressed = false
var atTexture: Texture = load("res://Assets/Pickup Sprites/Pickuptileset.png")
var weaponAtlas: AtlasTexture
var modifier1Atlas: AtlasTexture
var modifier2Atlas: AtlasTexture
var modifier3Atlas: AtlasTexture
var elementSlot = 3

func _ready():
	weaponAtlas = AtlasTexture.new()
	modifier1Atlas = AtlasTexture.new()
	modifier2Atlas = AtlasTexture.new()
	modifier3Atlas = AtlasTexture.new()
	weaponAtlas.atlas = atTexture
	modifier1Atlas.atlas = atTexture
	modifier2Atlas.atlas = atTexture
	modifier3Atlas.atlas = atTexture

func resetPressed():
	Global.mod1Pressed = false
	Global.mod2Pressed = false
	Global.mod3Pressed = false
	weaponPressed = false
	%Modifier1.self_modulate = "ffffff"
	%Modifier2.self_modulate = "ffffff"
	%Modifier3.self_modulate = "ffffff"
	%WeaponSlot1.self_modulate = "ffffff"

func modSlot():
	if Global.mod1Pressed == true:
		modifier1Atlas.region = Rect2(32, 0, 32, 32)
		%EquipedMod1.texture = modifier1Atlas
		if elementSlot == 1:
			%EquipedMod2.texture = null
		if elementSlot == 2:
			%EquipedMod3.texture = null
		elementSlot = 0
	if Global.mod2Pressed == true:
		modifier2Atlas.region = Rect2(32, 0, 32, 32)
		%EquipedMod2.texture = modifier2Atlas
		if elementSlot == 0:
			%EquipedMod1.texture = null
		if elementSlot == 2:
			%EquipedMod3.texture = null
		elementSlot = 1
	if Global.mod3Pressed == true:
		modifier3Atlas.region = Rect2(32, 0, 32, 32)
		%EquipedMod3.texture = modifier3Atlas
		if elementSlot == 0:
			%EquipedMod1.texture = null
		if elementSlot == 1:
			%EquipedMod2.texture = null
		elementSlot = 2

func _on_weapon_equiped_pressed():
	if weaponPressed == false:
		resetPressed()
		%WeaponEquip.show()
		%ModEquip.hide()
		%WeaponSlot1.self_modulate = "f8b400"
		weaponPressed = true
	else :
		%WeaponEquip.hide()
		%ModEquip.hide()
		weaponPressed = false


func _on_modifier_1_pressed():
	if Global.mod1Pressed == false:
		resetPressed()
		%ModEquip.show()
		%WeaponEquip.hide()
		%Modifier1.self_modulate = "f8b400"
		Global.mod1Pressed = true
	else:
		%ModEquip.hide()
		%WeaponEquip.hide()
		Global.mod1Pressed = false
func _on_modifier_2_pressed():
	if Global.mod2Pressed == false:
		resetPressed()
		%ModEquip.show()
		%WeaponEquip.hide()
		%Modifier2.self_modulate = "f8b400"
		Global.mod2Pressed = true
	else:
		%ModEquip.hide()
		%WeaponEquip.hide()
		Global.mod2Pressed = false
func _on_modifier_3_pressed():
	if Global.mod3Pressed == false:
		resetPressed()
		%ModEquip.show()
		%WeaponEquip.hide()
		%Modifier3.self_modulate = "f8b400"
		Global.mod3Pressed = true
	else:
		%ModEquip.hide()
		%WeaponEquip.hide()
		Global.mod3Pressed = false


func _on_exit_btn_pressed():
	get_tree().quit()


func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _process(_delta):
	#WEAPONS
	if Global.nailgunEquiped == true:
		weaponAtlas.region = Rect2(0, 0, 32, 32)
		%EquipedWeapon.texture = weaponAtlas
	if Global.crowbarEquiped == true:
		weaponAtlas.region = Rect2(96, 0, 32, 32)
		%EquipedWeapon.texture = weaponAtlas
	if Global.tapeMeasureEquiped == true:
		weaponAtlas.region = Rect2(32, 0, 32, 32)
		%EquipedWeapon.texture = weaponAtlas
	if Global.sixPackEquiped == true:
		weaponAtlas.region = Rect2(32, 0, 32, 32)
		%EquipedWeapon.texture = weaponAtlas
	#MODIFIERS
	if Global.poisonEquiped == true:
		modSlot()
	if Global.iceEquiped == true:
		modSlot()
	if Global.fireEquiped == true:
		modSlot()

