extends CharacterBody2D

@export var move_speed: float = 300
@onready var sprite: Sprite2D = $Sprite2D
@onready var main_script: Node = get_tree().root.get_node("main")

var player_size: float = 0.5
var is_alive: bool = true

func _physics_process(_delta: float) -> void:
	_movement()	
	move_and_slide()
	
func _movement():
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if is_alive:
		velocity = direction * move_speed
		
		if velocity.x < 0:
			sprite.rotation_degrees = -20
		elif velocity.x > 0:
			sprite.rotation_degrees = 20
		else:
			sprite.rotation_degrees = 0
			
		if velocity.y > 0 or velocity.y < 0:
			sprite.scale = Vector2(player_size, player_size - 0.3)
		else:
			sprite.scale = Vector2(player_size, player_size)
			
		if position.y < -10 or position.y > 450:
			is_alive = false
			print("DEAD")
		elif position.x < -70 or position.x > 740:
			is_alive = false
			print("DEAD")
	else:
		main_script.game_over_screen.show()
