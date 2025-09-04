extends CharacterBody2D

@export_category("Player Properties")
@export var move_speed : float = 200

@onready var player_sprite = $AnimatedSprite2D
@onready var spawn_point = %SpawnPoint
@onready var death_particles = $DeathParticles


func _process(_delta):
	movement()
	player_animations()

# -------- Movement --------
func movement():
	var dir = Vector2.ZERO
	if Input.is_action_pressed("Right"):
		dir.x += 1
	if Input.is_action_pressed("Left"):
		dir.x -= 1
	if Input.is_action_pressed("Down"):
		dir.y += 1
	if Input.is_action_pressed("Up"):
		dir.y -= 1

	velocity = dir.normalized() * move_speed
	move_and_slide()

# -------- Animations --------
func player_animations():
	if velocity.length() > 0:
		player_sprite.play("Walk")
		# 👇 เพิ่มตรงนี้
		if velocity.x != 0:
			player_sprite.flip_h = velocity.x < 0

	else:
		player_sprite.play("Idle")

# -------- Death/Respawn --------
func death_tween():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15)
	await tween.finished
	global_position = spawn_point.global_position
	await get_tree().create_timer(0.3).timeout
	AudioManager.respawn_sfx.play()
	respawn_tween()

func respawn_tween():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.15)

# -------- Signals --------
func _on_collision_body_entered(_body):
	if _body.is_in_group("Traps"):
		AudioManager.death_sfx.play()
		death_particles.emitting = true
		death_tween()
		
func _ready():
	# นี่คือโค้ดที่คุณมีอยู่แล้ว
	var scene_name = get_tree().current_scene.name
	if GameManager.spawn_door != "" and GameManager.door_positions.has(scene_name):
		if GameManager.door_positions[scene_name].has(GameManager.spawn_door):
			global_position = GameManager.door_positions[scene_name][GameManager.spawn_door]
	GameManager.spawn_door = ""

	# เพิ่มโค้ดสำหรับเชื่อมต่อสัญญาณ Game Over
	# Global.game_over.connect(_on_game_over)
	


func _on_game_over():
	set_process(false)
	set_physics_process(false)
