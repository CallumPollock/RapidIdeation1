extends CharacterBody2D


const walkSpeed = 100.0
const runSpeed = 200.0
var moveSpeed = 100.0
const JUMP_VELOCITY = -200.0
var max_jumps = 1
var jumps = max_jumps


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer2")
@onready var jump_audio = get_node("AudioStreamPlayer2D")
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jumps = max_jumps

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and jumps > 0:
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
		jump_audio.play()
		jumps -= 1
		
	if Input.is_action_pressed("sprint"):
		moveSpeed = runSpeed
	else:
		moveSpeed = walkSpeed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("walk_left", "walk_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = false
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = true
	if direction:
		velocity.x = direction * moveSpeed
		if velocity.y == 0:
			if Input.is_action_pressed("sprint"):
				anim.play("Run")
			else:
				anim.play("Walk")

	else:
		velocity.x = move_toward(velocity.x, 0, moveSpeed)
		if velocity.y ==0:
			anim.play("Idle")
			
	if velocity.y > 0:
		anim.play("Fall")
	move_and_slide()


