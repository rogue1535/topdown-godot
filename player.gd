extends CharacterBody2D
var current_exp =0
@export var speed = 100
var hp = Main.Playerhp 
@export var manbullet = preload("res://manualbullet.tscn")
@export var moltov = preload("res://nade.tscn")
signal time
signal player_bulllet_fired
signal upgrade

func _ready():
	Main.exp.connect(on_exp_picked)
	upgrade.connect(on_upgrade)
	
func _process(delta):
	if Input.is_action_pressed("end"):
		get_tree().quit()
	velocity = get_global_mouse_position() - self.global_position
	velocity = velocity.normalized() * speed
	position += velocity * delta
	move_and_collide(velocity*delta)


func manual():
	var manbullets = manbullet.instantiate()
	$"../bullets".add_child(manbullets)
	var MBdirection = (get_global_mouse_position() - self.global_position).normalized()
	var MBdir = MBdirection * 6
	manbullets.global_position =  self.global_position + MBdir
	manbullets.velocity = get_global_mouse_position() - self.global_position
	manbullets.look_at(get_global_mouse_position())
	

func auto():
	var manbullets = manbullet.instantiate()
	$"../bullets".add_child(manbullets)
	var ABdirection = (get_global_mouse_position() - self.global_position).normalized()
	var ABdir = ABdirection *6
	manbullets.global_position =  self.global_position + ABdir 
	manbullets.velocity = (Main.target.global_position - self.global_position) *.5 
	manbullets.look_at(Main.target.global_position)
	manbullets.target = Main.target
	
	
func _on_auto_timer_timeout():
	if Main.target != null:
		auto()
	else:
		Main.distarget = 10000


func _on_dmg_body_entered(body):
	
	var dmg = abs((self.global_position - body.global_position)).length()
	if body.is_in_group('enemy') ==true:
		if abs((self.global_position - body.global_position)).length() <= 30:
			Main.Hp -=1
			if Main.Hp <=0:
				Main.Hp = 10
				Main.score = 0
				current_exp = 0
				get_tree().reload_current_scene()
				
		print(abs((self.global_position - body.global_position)).length())

func on_exp_picked():
	current_exp+=1
	if current_exp >= 10 :
		print('upgrade')
		emit_signal('upgrade')
		current_exp = 0

func on_upgrade():
	pass


func _on_manual_timer_timeout():
	manual()


func _on_moltov_timer_timeout():
	var Moltov = moltov.instantiate()
	$"../bullets".add_child(Moltov)
	Moltov.position = self.position
	Moltov.velocity.y = -100*get_process_delta_time()
	Moltov.velocity = Moltov.velocity.rotated(randi_range(0, 2*PI))

	
