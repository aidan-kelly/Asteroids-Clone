extends Area2D

@onready var screen_size = get_viewport_rect().size

var speed: int = 1000
var direction: Vector2 = Vector2.UP

func _ready() -> void:
	$SelfDestructTimer.start()

func _process(delta: float) -> void:
	#Screen wrapping.
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	
	position += direction * speed * delta

func _on_self_destruct_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if "on_hit" in body:
		body.on_hit()
	queue_free()
