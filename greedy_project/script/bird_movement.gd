extends CharacterBody2D

@export var speed: float = 270
@export var gravity: int = 1000

@onready var jetpack_flame: CPUParticles2D = $jetpack_flame

func _ready() -> void:
	jetpack_flame.emitting = false

func _physics_process(delta: float) -> void:

	velocity.y += gravity * delta
	
	fly()
	move_and_slide()

func fly() -> void:
	var move_up = Vector2.UP * speed
	
	if Input.is_action_pressed("fly"):
		velocity = move_up
		jetpack_flame.emitting = true
	else:
		jetpack_flame.emitting = false
