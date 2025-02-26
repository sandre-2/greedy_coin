extends CharacterBody2D

@export var speed: float = 270
@export var gravity: int = 1000
@export var max_fall_speed: int = 800

@onready var jetpack_flame: CPUParticles2D = $jetpack_flame

var is_touch: bool

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		is_touch = event.pressed

func _physics_process(delta: float) -> void:

	velocity.y += gravity * delta
	velocity.y = min(velocity.y, max_fall_speed)
	fly()
	move_and_slide()

func fly() -> void:
	if Input.is_action_pressed("fly") or is_touch:
		
		velocity.y = -speed
		jetpack_flame.emitting = true
	else:
		jetpack_flame.emitting = false
