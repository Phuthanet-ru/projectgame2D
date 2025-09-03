extends CharacterBody2D

@export var speed: float = 100
@export var chase_range: float = 200  # ระยะตรวจจับ

var player: Node2D = null

func _ready() -> void:
	# หาผู้เล่น (สมมติ Player อยู่ใน group "Player")
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	var distance = global_position.distance_to(player.global_position)

	if distance < chase_range:
		# เดินเข้าหาผู้เล่น
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		# Spawn Game Over UI
		var game_over_ui = load("res://Scenes/Prefabs/game_over.tscn").instantiate()
		get_tree().current_scene.add_child(game_over_ui)
