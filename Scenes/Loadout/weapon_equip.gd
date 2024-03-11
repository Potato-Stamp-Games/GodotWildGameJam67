extends MarginContainer
#Unequip all weapons
func unequipAll():
	%NailgunEquiped.hide()
	%CrowbarEquiped.hide()
	%TapeMeasureEquipped.hide()
	%SixPackEquiped.hide()
	Global.nailgunEquiped = false
	Global.crowbarEquiped = false
	Global.tapeMeasureEquiped = false
	Global.sixPackEquiped = false
#On EQUIP button press
func _on_nailgun_btn_pressed():
	unequipAll()
	%NailgunEquiped.show()
	Global.nailgunEquiped = true
func _on_crowbar_btn_pressed():
	unequipAll()
	%CrowbarEquiped.show()
	Global.crowbarEquiped = true
func _on_tape_measure_btn_pressed():
	unequipAll()
	%TapeMeasureEquipped.show()
	Global.tapeMeasureEquiped = true
func _on_six_pack_btn_pressed():
	unequipAll()
	%SixPackEquiped.show()
	Global.sixPackEquiped = true
