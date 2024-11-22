extends AsteroidBase
signal spawn_small(pos, count)

func on_hit() -> void:
	#spawn in 2 smaller asteroids.
	Globals.score_amount += 100
	spawn_small.emit(global_position, 3)
	asteroid_hit.emit()
	queue_free()
