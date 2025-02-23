extends Area2D

@export var move_speed: float = 700

@onready var main_script: Node = get_tree().root.get_node("main")

func _process(delta: float) -> void:
	position += Vector2.LEFT * move_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		main_script._lose_health()
	
	if main_script.health <= 0:
		body.queue_free()
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
