extends Area2D

@export var speed: float = 220.0            # ความเร็วปกติ
@export var sprint_multiplier: float = 1.6  # คูณเมื่อกดปุ่ม run
var screen_size: Vector2
const BORDER := Vector2(16, 16)             # กันชิดขอบจอ

const ANIM_SIDE := "run"                    # มีอนิเมชันเดียวชื่อ run

func _ready() -> void:
	screen_size = get_viewport_rect().size

	# ใส่ type ให้ชัดเจน
	var frames: SpriteFrames = $AnimatedSprite2D.sprite_frames
	if frames == null:
		push_error("AnimatedSprite2D.sprite_frames is null.")
		return

	if frames.has_animation(ANIM_SIDE):
		$AnimatedSprite2D.animation = ANIM_SIDE
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.stop()
	else:
		# ใน Godot 4 คืนค่าเป็น PackedStringArray
		var names: PackedStringArray = frames.get_animation_names()
		if names.size() == 0:
			push_error("AnimatedSprite2D has no animations at all.")
			return
		push_warning("No animation '%s'. Fallback to '%s'." % [ANIM_SIDE, names[0]])
		$AnimatedSprite2D.animation = names[0]
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.stop()

func _process(delta: float) -> void:
	var dir := Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		dir.x += 1.0
	if Input.is_action_pressed("move_left"):
		dir.x -= 1.0
	if Input.is_action_pressed("move_down"):
		dir.y += 1.0
	if Input.is_action_pressed("move_up"):
		dir.y -= 1.0

	if dir != Vector2.ZERO:
		dir = dir.normalized()

		var current_speed := speed
		if Input.is_action_pressed("run"):   # ปุ่ม R ตาม Input Map ในรูป
			current_speed *= sprint_multiplier

		# อนิเมชัน run มุมมองด้านข้าง → แค่สลับซ้าย/ขวา
		if abs(dir.x) >= abs(dir.y):
			$AnimatedSprite2D.flip_h = dir.x < 0
		# ขึ้น/ลง ใช้สไปรต์ด้านข้างเดิม

		if !$AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play()

		position += dir * current_speed * delta
		position = position.clamp(BORDER, screen_size - BORDER)
	else:
		if $AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 0
