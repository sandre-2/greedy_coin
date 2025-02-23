extends Area2D

@export var move_speed: float = 450

@onready var main_script: Node = get_tree().root.get_node("main")

func _process(delta: float) -> void:
	position += Vector2.LEFT * move_speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		main_script._add_points()
		queue_free()
	
func _on_screen_notify_screen_exited() -> void:
	queue_free()
