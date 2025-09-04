extends Area2D

@onready var frame_sound: AudioStreamPlayer2D = $FrameSound
@onready var close_sfx: AudioStreamPlayer2D = $CloseSfx
@onready var prompt: Label = $Prompt

var player_inside: bool = false
var sound_on: bool = false

func _ready() -> void:
	prompt.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = true
		prompt.visible = true
		prompt.text = "กด E หยุด" if sound_on else "กด E "

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = false
		prompt.visible = false

# ในสคริปต์ที่ควบคุมการเกิดของผี
func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		if sound_on:
			frame_sound.stop()
			close_sfx.play()
			sound_on = false
		else:
			frame_sound.play()
			sound_on = true

			# โหลด Scene ผี
			var ghost_scene = load("res://Scenes/Prefabs/ghost.tscn")
			var ghost = ghost_scene.instantiate()
			get_tree().current_scene.add_child(ghost)

			# กำหนดพิกัดที่ผีจะเกิด
			ghost.global_position = Vector2(881, 312) # เปลี่ยนตัวเลขนี้เป็นพิกัดที่ต้องการ
			
