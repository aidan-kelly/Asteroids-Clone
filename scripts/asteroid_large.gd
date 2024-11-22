extends RigidBody2D
class_name AsteroidBase
signal spawn_medium(pos, count)
signal asteroid_hit()

@onready var screen_size = get_viewport_rect().size

var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
var speed = 250
var rotation_amount = randf_range(-1,1)


func _process(delta: float) -> void:
	rotate(rotation_amount * delta)
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	var motion = (direction * delta) * speed
	var collision_info = move_and_collide(motion)
	if collision_info:
		if "player_hit" in collision_info.get_collider():
			collision_info.get_collider().player_hit()
		direction = direction.bounce(collision_info.get_normal())

func on_hit() -> void:
	#spawn in 2 smaller asteroids.
	Globals.score_amount += 50
	spawn_medium.emit(global_position, 2)
	asteroid_hit.emit()
	queue_free()


func _on_body_entered(body: Node) -> void:
	print(body)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
