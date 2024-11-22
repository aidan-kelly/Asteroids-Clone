extends CharacterBody2D

signal projectile(pos: Vector2, player_direction: Vector2)

@onready var screen_size = get_viewport_rect().size

#Constants.
const ROTATIONAL_CONST = 0.05
const DRAG = 0.75
const ACCELERATION = 2
const SPEED = 300

var can_shoot = true
var is_invulnerable = false

func _physics_process(delta: float) -> void:
	#Screen wrapping.
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

	#Rotate the ship.
	var rotation_direction := Input.get_axis("left", "right")
	rotate(rotation_direction * ROTATIONAL_CONST)
	
	#If thrust is being pressed, we move the ship forward. 
	if Input.is_action_pressed("thrust"):
		$ThrusterParticles.emitting = true
		if not $ThrustSound.is_playing():
			$ThrustSound.play()
		#Can get a direction vector using this from_angle method!
		var goal_velocity = Vector2.from_angle(rotation) * SPEED
		velocity.x = move_toward(velocity.x, goal_velocity.x, ACCELERATION)
		velocity.y = move_toward(velocity.y, goal_velocity.y, ACCELERATION)
	else:
		$ThrusterParticles.emitting = false
		$ThrustSound.stop()
		velocity.x = move_toward(velocity.x, 0, DRAG)
		velocity.y = move_toward(velocity.y, 0, DRAG)
		
	if Input.is_action_pressed("shoot") and can_shoot:
		#handle the shooting here. 
		can_shoot = false
		$GunTimer.start()
		projectile.emit($Marker2D.global_position, Vector2.from_angle(rotation))
	move_and_slide()

func _on_gun_timer_timeout() -> void:
	can_shoot = true

func player_hit():
	if not is_invulnerable:
		#probably a better way of doing this lol
		var tween = create_tween()
		tween.tween_property($Sprite2D, "visible", false, 0.25)
		tween.tween_property($Sprite2D, "visible", true, 0.25)
		tween.tween_property($Sprite2D, "visible", false, 0.25)
		tween.tween_property($Sprite2D, "visible", true, 0.25)
		$PlayerHurt.play()
		Globals.lives_amount -= 1
		is_invulnerable = true
		$InvulnTimer.start()

func _on_invuln_timer_timeout() -> void:
	is_invulnerable = false
