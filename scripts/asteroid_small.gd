extends AsteroidBase

func on_hit() -> void:
	Globals.score_amount += 150
	asteroid_hit.emit()
	queue_free()
