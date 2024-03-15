extends CharacterBody2D

var movement_speed = 100
var hp = 100

#Attacks
var nailGun = preload("res://Attack/nail_shot.tscn")

#Attack Nodes
@onready var nailGunTimer = get_node("%NailGunTimer")
@onready var nailGunAttackTimer = get_node("%NailGunAttackTimer")

#Nail Gun
var nailgun_ammo = 0
var nailgun_baseammo = 1
var nailgun_attackspeed = 1.5
var nailgun_level = 1

#Enemy Related 
var enemy_close = []

@onready var sprite_2d = $Sprite2D

func _ready():
	attack()
	sprite_2d.play("default")

func _physics_process(delta):
	movement()
	

func attack():
	if nailgun_level > 0:
		nailGunTimer.wait_time = nailgun_attackspeed
		if nailGunTimer.is_stopped():
			nailGunTimer.start()

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up")
	var mov = Vector2(x_mov, y_mov)
	velocity = mov.normalized()*movement_speed
	move_and_slide()
	
	if Input.is_action_just_pressed("up"):
		sprite_2d.play("walk_backward")
	if Input.is_action_just_pressed("down"):
		sprite_2d.play("walk_forward")
	if Input.is_action_just_pressed("left"):
		sprite_2d.play("walk_left")
	if Input.is_action_just_pressed("right"):
		sprite_2d.play("walk_right")


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
	if hp <= 0:
		queue_free()


func _on_nail_gun_timer_timeout():
	nailgun_ammo += nailgun_ammo
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
