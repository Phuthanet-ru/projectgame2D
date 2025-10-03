# DoorLocked.gd
extends Area2D

@onready var prompt: Label = $Prompt
@onready var knock_sfx: AudioStreamPlayer2D = $KnockSfx

@export var hint_text := "กด E เพื่อเปิด"
@export var locked_text := "ประตูล็อก"
@export var show_locked_secs := 1.2
@export var is_locked := true        # ตอนนี้ให้ล็อกไว้ก่อน
@export var next_scene_path := ""    # ถ้าปลดล็อกจะเปลี่ยนซีนให้ (ถ้าไม่เซ็ตจะไม่ทำอะไร)

var player_inside := false
var _reverting := false

func _ready() -> void:
	prompt.visible = false
	prompt.text = hint_text
	body_entered.connect(_on_enter)
	body_exited.connect(_on_exit)

func _on_enter(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = true
		prompt.visible = true

func _on_exit(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = false
		prompt.visible = false

# เพิ่มตัวแปรสำหรับฉากจบเกม
@export var ending_scene_path := "res://Scenes/Ending.tscn"

func _process(_dt: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		if is_locked:
			# ตรวจสอบว่าผู้เล่นมีกุญแจหรือไม่
			if GameManager.has_key:
				is_locked = false # ปลดล็อกประตู
				_open_door()
			else:
				_knock_and_flash_locked()
		else:
			_open_door()

func _knock_and_flash_locked() -> void:
	if knock_sfx:
		knock_sfx.play()
	# เปลี่ยนข้อความเป็น “ประตูล็อก” ชั่วคราว แล้วกลับเป็น hint
	if not _reverting:
		_reverting = true
		var old := prompt.text
		prompt.text = locked_text
		await get_tree().create_timer(show_locked_secs).timeout
		if player_inside:  # ยังยืนอยู่หน้าประตูอยู่ไหม
			prompt.text = hint_text
		_reverting = false

func _open_door() -> void:
	# เมื่อประตูถูกเปิด ให้เปลี่ยนไปฉากจบเกมทันที
	SceneTransition.fade_to_scene(load("res://Scenes/Prefabs/ending.tscn"))
