extends KinematicBody2D

var ddp = 0.0
var dp  = 0.0
var p   = 0.0
export var acceleration = 2000000
export var friction_coeff = 20

func _ready():
	$sprite.animation = "idle"
	$sprite.play()

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		$sprite.animation = "run"
		$sprite.flip_h = false
		ddp = acceleration
		
	elif Input.is_action_pressed("ui_left"):
		$sprite.animation = "run"
		$sprite.flip_h = true
		ddp = -acceleration
	else:
		$sprite.animation = "idle"
	ddp -= friction_coeff*dp

func _physics_process(delta):
	dp = ddp*delta
	p = dp*delta + 0.5*ddp*delta*delta
	move_and_slide(Vector2(p, 0.0), Vector2(0.0, -1.0))
