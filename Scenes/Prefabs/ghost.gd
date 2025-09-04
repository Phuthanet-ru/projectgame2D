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
	
# ในสคริปต์ของผี (ghost.gd)
func _on_body_entered(body):
	if body.name == "Player":
		# หยุดการทำงานของสคริปต์ผู้เล่น
		body.set_process(false)
		body.set_physics_process(false)

		# เรียกใช้ SceneTransition โดยส่งพาธของฉาก Game Over ไป
		SceneTransition.fade_to_scene(load("res://Scenes/Prefabs/game_over.tscn"))
