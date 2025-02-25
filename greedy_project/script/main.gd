extends Node2D

@onready var coin_timer: Timer = $timers/coin_timer
@onready var bomb_timer: Timer = $timers/bomb_timer
@onready var increase_bomb_timer: Timer = $timers/increase_bomb_timer

@onready var score_text: Label = $hud/score
@onready var health_bar: ProgressBar = $player/health_bar
@onready var game_over_screen: CanvasLayer = $hud/game_over_screen

@onready var bg_music: AudioStreamPlayer2D = $sounds/bg_music
@onready var bomb_sound: AudioStreamPlayer2D = $sounds/bomb_sound
@onready var coin_sfx: AudioStreamPlayer2D = $sounds/coin_sfx

@onready var coin_scene: PackedScene = preload("res://scene/coin.tscn")
@onready var bomb_scene: PackedScene = preload("res://scene/bomb.tscn")

var score: int = 0
var health: int = 3
var minimum_range: int = 30
var maximum_range: int = 290
var spawn_point: int = 700
var phase_counter: int

func _ready() -> void:
	health_bar.value = health
	game_over_screen.hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func _on_coin_timer_timeout() -> void:
	_coin_spawner()

func _coin_spawner() -> void:
	var coin_instance = coin_scene.instantiate()
	coin_instance.position = Vector2(spawn_point, randf_range(minimum_range, maximum_range))
	add_child(coin_instance)
	
func _add_points() -> void:
	score += 1
	score_text.text = str(score)
	coin_sfx.play()

func _on_bomb_timer_timeout() -> void:
	var bomb_instance = bomb_scene.instantiate()
	bomb_instance.position = Vector2(spawn_point, randf_range(minimum_range, maximum_range))
	add_child(bomb_instance)
	
func _lose_health() -> void:
	health -= 1
	health_bar.value = health
	bomb_sound.play()

func _on_increase_bomb_timer_timeout() -> void:
	bomb_timer.wait_time -= 0.2
	phase_counter += 1
	print("NEXT PHASE -> Speed: " + str(bomb_timer.wait_time))
	
	if phase_counter > 2:
		increase_bomb_timer.stop()

func _on_restart_game_button_up() -> void:
	get_tree().reload_current_scene()

func _on_quit_game_button_up() -> void:
	get_tree().quit()
