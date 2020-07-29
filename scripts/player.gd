extends KinematicBody2D

var pixel_per_meter = 37.037

var total_f = Vector2()
var ddp = Vector2()
var dp  = Vector2()
export var leg_strength = 5000
export var mass = 80.0
export var friction_coeff = 0.95
export var gravity = 9.81
export var jump_strength = 3000

func _ready():
	$sprite.animation = "idle"
	$sprite.play()

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		$sprite.animation = "run"
		$sprite.flip_h = false
		total_f.x = leg_strength
	elif Input.is_action_pressed("ui_left"):
		$sprite.animation = "run"
		$sprite.flip_h = true
		total_f.x = -leg_strength
	else:
		$sprite.animation = "idle"
		total_f.x = 0
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		total_f.y = -jump_strength*gravity
	else:
		total_f.y = gravity*mass*7
	ddp.x -= friction_coeff*dp.x

	var friction = -mass*gravity*friction_coeff * dp.x
	total_f.x += friction
	ddp = total_f / mass

func _physics_process(delta):
	dp += ddp*delta
	move_and_slide(dp*pixel_per_meter, Vector2(0.0, -1.0))
	if is_on_floor():
		dp.y = 0
		
	if abs(dp.x) < 0.1:
		dp.x = 0
