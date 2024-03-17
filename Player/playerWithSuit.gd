extends CharacterBody2D

var movement_speed = 100
var last_movement = Vector2.UP
var hp = 100
var maxHp = 100
var time = 0

var experience = 0
var experience_level = 1
var collected_experience = 0

#Attacks
var nailGun = preload("res://Attack/nail_shot.tscn")
var SixPack = preload("res://Attack/beer_can.tscn")
var measuringTape = preload("res://Attack/measuring_tape.tscn")

#Attack Nodes
@onready var nailGunTimer = get_node("%NailGunTimer")
@onready var nailGunAttackTimer = get_node("%NailGunAttackTimer")
@onready var SixPackTimer = get_node("%SixPackTimer")
@onready var SixPackAttackTimer = get_node("%SixPackAttackTimer")
@onready var measuringTapeBase = get_node("%MeasuringTapeBase")

#UPGRADES
var collected_upgrades = []
var upgrade_options = []
var armor = 0
var speed = 0
var spell_cooldown = 0
var spell_size = 0
var additional_attacks = 0
var collectedResearchPoints = 0

#Nail Gun
var nailgun_ammo = 0
var nailgun_baseammo = 1
var nailgun_attackspeed = 1.5
var nailgun_level = 0

#Six Pack
var sixpack_ammo = 0
var sixpack_baseammo = 1
var sixpack_attackspeed = 1.5
var sixpack_level = 0

#Measuring Tape
var measuringtape_ammo = 1
var measuringtape_level = 0

#Enemy Related 
var enemy_close = []

#GUI
@onready var expBar = get_node("%ExperienceBar")
@onready var lblLevel = get_node("%LevelLabel")
@onready var healthBar = get_node("%HealthBar")
@onready var deathPanel = get_node("%$GameOverPanel")
@onready var upgradeOptions = get_node("%UpgradeOptions")
@onready var itemOptions = preload("res://Utility/item_option.tscn")
@onready var levelUpPanel = get_node("%LevelUpPanel")
@onready var victoryPanel = get_node("%VictoryPanel")
@onready var collectedWeapons = get_node("%CollectedWeapons")
@onready var collectedUpgrades = get_node("%CollectedUpgrades")
@onready var itemContainer = preload("res://Player/GUI/item_container.tscn")
@onready var lblTimer = get_node("%lblTimer")
@onready var sprite_2d = $Sprite2D
@onready var rp_label = get_node("%RPLabel")

func _ready():
	determineStartingWeapon()
	rp_label.text = "0"
	attack()
	set_expbar(experience, calculate_experiencecap())
	sprite_2d.play("default")

func determineStartingWeapon():
	if Global.nailgunEquiped == true:
		upgrade_character("nailgun1")
	if Global.tapeMeasureEquiped == true:
		upgrade_character("measuringtape1")
	if Global.sixPackEquiped == true:
		upgrade_character("sixpack1")
		

func _physics_process(delta):
	movement()
	

func attack():
	if nailgun_level > 0:
		nailGunTimer.wait_time = nailgun_attackspeed
		if nailGunTimer.is_stopped():
			nailGunTimer.start()
	if sixpack_level > 0:
		SixPackTimer.wait_time = sixpack_attackspeed
		if SixPackTimer.is_stopped():
			SixPackTimer.start()
	if measuringtape_level > 0:
		spawn_measuringTape()

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up")
	var mov = Vector2(x_mov, y_mov)
	
	if mov != Vector2.ZERO:
		last_movement = mov

	if Input.is_action_just_pressed("up"):
		sprite_2d.play("walk_backward")
	if Input.is_action_just_pressed("down"):
		sprite_2d.play("walk_forward")
	if Input.is_action_just_pressed("left"):
		sprite_2d.play("walk_left")
	if Input.is_action_just_pressed("right"):
		sprite_2d.play("walk_right")
	
	velocity = mov.normalized()*movement_speed
	move_and_slide()

func spawn_measuringTape():
	var get_measuringTape_total = measuringTapeBase.get_child_count()
	var calc_spawns = (measuringtape_ammo + additional_attacks) - get_measuringTape_total
	while calc_spawns > 0:
		var measuringTape_spawn = measuringTape.instantiate()
		measuringTape_spawn.global_position = global_position
		measuringTapeBase.add_child(measuringTape_spawn)
		calc_spawns -= 1
	#Upgrade Measuring Tape
	var get_measuringTapes = measuringTapeBase.get_children()
	for i in get_measuringTapes:
		if i.has_method("update_measuringTape"):
			i.update_measuringTape()

func _on_hurt_box_hurt(damage, _angle, _knockback):
	hp -= damage
	healthBar.max_value = maxHp
	healthBar.value = hp
	if hp <= 0:
		death()

func _on_nail_gun_timer_timeout():
	nailgun_ammo += nailgun_baseammo
	nailGunAttackTimer.start()

func _on_nail_gun_attack_timer_timeout():
	if nailgun_ammo > 0:
		var nailgun_attack = nailGun.instantiate()
		nailgun_attack.position = position
		nailgun_attack.target = get_random_target()
		nailgun_attack.level = nailgun_level
		add_child(nailgun_attack)
		nailgun_ammo -= 1
		if nailgun_ammo > 0:
			nailGunAttackTimer.start()
		else:
			nailGunAttackTimer.stop

func _on_pack_timer_timeout():
	sixpack_ammo += sixpack_baseammo
	SixPackAttackTimer.start()

func _on_pack_attack_timer_timeout():
	if sixpack_ammo > 0:
		var sixpack_attack = SixPack.instantiate()
		sixpack_attack.position = position
		sixpack_attack.last_movement = last_movement
		sixpack_attack.level = sixpack_level
		add_child(sixpack_attack)
		sixpack_ammo -= 1
		if sixpack_ammo > 0:
			SixPackAttackTimer.start()
		else:
			SixPackAttackTimer.stop

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)

func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		if area.is_in_group("xp"):
			var gem_exp = area.Collect()
			calculate_experience(gem_exp)
		if area.is_in_group("rp"):
			var research_point = area.CollectRP()
			collectedResearchPoints += research_point
			rp_label.text = str(collectedResearchPoints)

func change_time(argtime = 0):
	time = argtime
	var get_m = int(time/60.0)
	var get_s = time % 60
	if get_m >= 10:
		victoryPanel.visible = true
		get_tree().paused = true
	if get_m < 10:
		get_m = str(0,get_m)
	if get_s < 10:
		get_s = str(0,get_s)
	lblTimer.text = str(get_m,":",get_s)
	

func calculate_experience(gem_exp):
	var exp_required = calculate_experiencecap()
	collected_experience += gem_exp
	if experience + collected_experience >= exp_required: #level up
		collected_experience -= exp_required-experience
		experience_level += 1
		experience = 0
		exp_required = calculate_experiencecap()
		levelup()
	else:
		experience += collected_experience
		collected_experience = 0
		
		set_expbar(experience, exp_required)

func calculate_experiencecap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level*5
	elif experience_level < 40:
		exp_cap + 95 * (experience_level-19)*8
	else:
		exp_cap = 255 + (experience_level-39)*12
	return exp_cap
		
func set_expbar(set_value = 1, set_max_value = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value

func levelup():
	lblLevel.text = str("Level: ",experience_level)
	levelUpPanel.visible = true
	var options = 0
	var optionsmax = 3
	while options < optionsmax:
		var option_choice = itemOptions.instantiate()
		option_choice.item = get_random_item()
		upgradeOptions.add_child(option_choice)
		options += 1
	get_tree().paused = true
		
func upgrade_character(upgrade):
	match upgrade:
		"nailgun1":
			nailgun_level = 1
		"nailgun2":
			nailgun_level = 2
			nailgun_baseammo += 1
		"nailgun3":
			nailgun_level = 3
		"nailgun4":
			nailgun_level = 4
			nailgun_baseammo += 2
		"sixpack1":
			sixpack_level = 1
		"sixpack2":
			sixpack_level = 2
			sixpack_baseammo += 1
		"sixpack3":
			sixpack_level = 3
			sixpack_baseammo -= 0.5
		"sixpack4":
			sixpack_level = 4
			sixpack_baseammo += 1
		"measuringtape1":
			measuringtape_level = 1
		"measuringtape2":
			measuringtape_level = 2
			measuringtape_ammo += 1
		"measuringtape3":
			measuringtape_level = 3
		"measuringtape4":
			measuringtape_level = 4
		"antibody1","antibody2","antibody3","antibody4":
			armor += 1
		"speed1","speed2","speed3","speed4":
			movement_speed += 50.0
		"attackspeed1","attackspeed2","attackspeed3","attackspeed4":
			if nailgun_level >= 1:
				nailgun_attackspeed = nailgun_attackspeed * 1.1
			if sixpack_level >= 1:
				sixpack_attackspeed = sixpack_attackspeed * 1.1
		"shrinkray1","shrinkray1","shrinkray1","shrinkray1":
			spell_size += 0.10
		"scroll1","scroll2","scroll3","scroll4":
			spell_cooldown += 0.05
		"extratape1","extratape2":
			measuringtape_ammo += 1
		"horsedewormer":
			hp += 20
			hp = clamp(hp,0,maxHp)
	adjust_gui_collection(upgrade)
	attack()
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	levelUpPanel.visible = false
	get_tree().paused = false
	calculate_experience(0)
		
func adjust_gui_collection(upgrade):
	var get_upgraded_displayname = UpgradeDb.UPGRADES[upgrade]["displayname"]
	var get_type = UpgradeDb.UPGRADES[upgrade]["type"]
	if get_type != "item":
		var get_collected_displaynames = []
		for i in collected_upgrades:
			get_collected_displaynames.append(UpgradeDb.UPGRADES[i]["displayname"])
		if not get_upgraded_displayname in get_collected_displaynames:
			var new_item = itemContainer.instantiate()
			new_item.upgrade = upgrade
			match get_type:
				"weapon":
					collectedWeapons.add_child(new_item)
				"upgrade":
					collectedUpgrades.add_child(new_item)
					
func get_random_item():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in collected_upgrades: #Find already collected upgrades
			pass
		elif i in upgrade_options: #If the upgrade is already an option
			pass
		elif UpgradeDb.UPGRADES[i]["type"] == "item": #Don't pick food
			pass
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0: #Check for PreRequisites
			var to_add = true
			for n in UpgradeDb.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades:
					to_add = false
			if to_add:
				dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null
		
func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _on_loadout_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Loadout/loadout.tscn")


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")
	
func death():
	Global.rsPoints = collectedResearchPoints
	%GameOverPanel.visible = true
	get_tree().paused = true
