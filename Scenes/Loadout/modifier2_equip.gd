extends MarginContainer
#Unequip all weapons
func unequipAll():
	%SpeedEquiped.hide()
	%DamageEquiped.hide()
	%AttackSEquiped.hide()
	Global.speedEquiped = false
	Global.damageEquiped = false
	Global.attackSEquiped = false
#On EQUIP button press
func _on_speed_btn_pressed():
	unequipAll()
	%SpeedEquiped.show()
	Global.speedEquiped = true
func _on_damage_btn_pressed():
	unequipAll()
	%DamageEquiped.show()
	Global.damageEquiped = true
func _on_attack_s_btn_pressed():
	unequipAll()
	%AttackSEquiped.show()
	Global.attackSEquiped = true
