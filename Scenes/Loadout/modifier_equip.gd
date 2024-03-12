extends MarginContainer

#Unequip all weapons
func unequipAllElements():
	%PoisonEquiped.hide()
	%IceEquiped.hide()
	%FireEquiped.hide()
	Global.poisonEquiped = false
	Global.iceEquiped = false
	Global.fireEquiped = false
#On EQUIP button press
func _on_poision_equiped_btn_pressed():
	if Global.poisonEquiped == false:
		unequipAllElements()
		%PoisonEquiped.show()
		Global.poisonEquiped = true
func _on_ice_equiped_btn_pressed():
	if Global.iceEquiped == false:
		unequipAllElements()
		%IceEquiped.show()
		Global.iceEquiped = true
func _on_fire_equiped_btn_pressed():
	if Global.fireEquiped == false:
		unequipAllElements()
		%FireEquiped.show()
		Global.fireEquiped = true
