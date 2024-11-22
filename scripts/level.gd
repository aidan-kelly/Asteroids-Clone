extends Node2D

var projectile_scene: PackedScene = preload("res://scenes/projectile.tscn")
var large_asteroid_scene: PackedScene = preload("res://scenes/asteroid_large.tscn")
var medium_asteroid_scene: PackedScene = preload("res://scenes/asteroid_medium.tscn")
var small_asteroid_scene: PackedScene = preload("res://scenes/asteroid_small.tscn")

var score

func _ready() -> void:
	Globals.score_amount = 0
	Globals.lives_amount = 3
	$AsteroidTimer.start()
	Globals.connect("stat_change", update_stat_text)

func _on_spaceship_projectile(pos: Variant, player_direction: Variant) -> void:
	var projectile = projectile_scene.instantiate()
	projectile.position = pos
	projectile.rotation = player_direction.angle()
	projectile.direction = player_direction
	$PlayerShoot.play()
	$Projectiles.add_child(projectile)

func spawn_asteroid(pos):
	var asteroid = large_asteroid_scene.instantiate()
	asteroid.position = pos
	asteroid.connect("spawn_medium", spawn_medium_asteroids)
	asteroid.connect("asteroid_hit", asteroid_hit)
	$Asteroids.add_child(asteroid)

func spawn_medium_asteroids(pos, count):
	for i in count:
		var medium_asteroid = medium_asteroid_scene.instantiate()
		medium_asteroid.position = pos
		medium_asteroid.connect("spawn_small", spawn_small_asteroids)
		medium_asteroid.connect("asteroid_hit", asteroid_hit)
		$Asteroids.add_child(medium_asteroid)

func spawn_small_asteroids(pos, count):
	for i in count:
		var small_asteroid = small_asteroid_scene.instantiate()
		small_asteroid.position = pos
		small_asteroid.connect("asteroid_hit", asteroid_hit)
		$Asteroids.add_child(small_asteroid)

func _on_asteroid_timer_timeout() -> void:
	var spawn_location = $AsteroidPath/AsteroidSpawnPath
	spawn_location.progress_ratio = randf()
	spawn_asteroid(spawn_location.position)

func asteroid_hit() -> void:
	$AsteroidHit.play()

func update_stat_text() -> void:
	$VBoxContainer/ScoreLabel.text = "Score: " + str(Globals.score_amount)
	$VBoxContainer/LivesLabel.text = "LIVES: " + str(Globals.lives_amount)
