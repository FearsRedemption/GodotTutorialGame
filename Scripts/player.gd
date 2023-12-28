extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = 700.0
@export var gravity = 30

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_velocity

	# Handle Horizontal Movement
	var h_direction = Input.get_axis("Move Left", "Move Right")
	velocity.x = h_direction * speed
	
	if h_direction != 0:
		sprite.flip_h = (h_direction == -1)

	move_and_slide()
	update_animations(h_direction)

func update_animations(h_direction):
	if is_on_floor():
		if h_direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	else:
		if velocity.y < 0:
			ap.play("jump")
		else:
			ap.play("fall")
