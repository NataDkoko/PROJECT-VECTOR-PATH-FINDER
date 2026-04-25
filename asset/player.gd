extends CharacterBody2D

@export var speed = 200
var last_direction = Vector2.DOWN

func _physics_process(delta):
	var direction = Vector2.ZERO

	# Input
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()

	var anim = $AnimatedSprite2D

	# Simpan arah terakhir
	if direction != Vector2.ZERO:
		last_direction = direction

	# Animasi
	if direction == Vector2.ZERO:
		anim.play("idle")
	else:
		play_run(anim, direction)


func play_run(anim, direction):
	if abs(direction.x) > abs(direction.y):
		anim.play("run_side")
		anim.flip_h = direction.x < 0
	elif direction.y > 0:
		anim.play("run_down")
	else:
		anim.play("run_up")
