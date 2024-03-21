extends Control
var rsSpeed: int = 0
var rsDamage: int = 0
var rsAtkSpeed: int = 0
var rsPoison: bool = false
var rsIce: bool = false
var rsFire: bool = false
var save_file: SaveFile
var rsPoints = Global.rsPoints

func _ready():
	save_file = SaveFile.load_or_create()
	if save_file:
		Global.rsDict = save_file.rsDict
	research_dict_set()
func _on_back_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/Loadout/loadout.tscn")

func research_dict_set():
	Global.rsDict = {"rsSpeed": rsSpeed, "rsDamage": rsDamage, "rsAtkSpeed": rsAtkSpeed, "rsPoison": rsPoison, "rsIce": rsIce, "rsFire": rsFire}
	%SpAmtLbl.text = str(rsSpeed)
	%DmgAmtLbl.text = str(rsDamage)
	%ASAmtLbl.text = str(rsAtkSpeed)
	%rsPointsLbl.text = str(Global.rsPoints)
	
	save_file.rsDict = Global.rsDict
	save_file.save()
	
func research_dict_get():
	rsSpeed = Global.rsDict["rsSpeed"] 
	rsDamage = Global.rsDict["rsDamage"]
	rsAtkSpeed = Global.rsDict["rsAtkSpeed"]
	rsPoison = Global.rsDict["rsPoison"]
	rsIce = Global.rsDict["rsIce"]
	rsFire = Global.rsDict["rsFire"]


func _on_speed_rs_btn_pressed():
	research_dict_get()
	if Global.rsPoints >= 30 and rsSpeed <= 9:
		Global.rsPoints -= 30
		rsSpeed += 1
		Global.rsBonusDict["rsSpeed"] += .15
		research_dict_set()
		if rsSpeed == 10:
			%SpeedRsBtn.disabled = true

func _on_damage_rs_btn_pressed():
	research_dict_get()
	if Global.rsPoints >= 30 and rsDamage <= 9:
		Global.rsPoints -= 30
		rsDamage += 1
		Global.rsBonusDict["rsDamage"] += 1
		research_dict_set()
		if rsDamage == 10:
			%DamageRsBtn.disabled = true

func _on_atk_speed_rs_btn_pressed():
	research_dict_get()
	if Global.rsPoints >= 30 and rsAtkSpeed <= 9:
		Global.rsPoints -= 30
		rsAtkSpeed += 1
		Global.rsBonusDict["rsAtkSpeed"] += .05
		research_dict_set()
		if rsAtkSpeed == 10:
			%AtkSpeedRsBtn.disabled = true
	

func _on_poison_rs_btn_pressed():
	research_dict_get()
	if Global.rsPoints >= 30 and rsPoison == false:
		Global.rsPoints -= 30
		rsPoison = true
		%PoisonRsBtn.disabled = true
		research_dict_set()

func _on_ice_rs_btn_pressed():
	research_dict_get()
	if Global.rsPoints >= 30 and rsIce == false:
		Global.rsPoints -= 30
		rsIce = true
		%IceRsBtn.disabled = true
		research_dict_set()

func _on_fire_rs_btn_pressed():
	research_dict_get()
	if Global.rsPoints >= 30 and rsFire == false:
		Global.rsPoints -= 30
		rsFire = true
		%FireRsBtn.disabled = true
		research_dict_set()
