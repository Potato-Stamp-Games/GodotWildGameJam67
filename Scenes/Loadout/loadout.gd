extends Control
var onWeaponPress = 0
var onModPress = 0

func _on_weapon_equiped_pressed():
	if onWeaponPress == 0:
		%WeaponEquip.show()
		onWeaponPress += 1
	else :
		%WeaponEquip.hide()
		onWeaponPress  = 0


func _on_modifier_1_pressed():
	if onModPress == 0:
		%ModEquip.show()
		onModPress += 1
	else :
		%ModEquip.hide()
		onModPress  = 0


func _on_modifier_2_pressed():
	if onModPress == 0:
		%ModEquip.show()
		onModPress += 1
	else :
		%ModEquip.hide()
		onModPress  = 0


func _on_modifier_3_pressed():
	if onModPress == 0:
		%ModEquip.show()
		onModPress += 1
	else :
		%ModEquip.hide()
		onModPress  = 0


func _on_exit_btn_pressed():
	get_tree().quit()


func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
