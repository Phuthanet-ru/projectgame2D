# PanArea.gd   (ติดกับ Area2D: PanArea)
extends Area2D

@onready var pan_sizzle: AudioStreamPlayer2D     = $PanSizzle           # เสียงกระทะ
@onready var close_sfx: AudioStreamPlayer2D      = $CloseSfx             # เสียงตอนปิด
@onready var prompt: Label                       = $Prompt               # ข้อความกด E
@onready var ambience: AudioStreamPlayer2D       = $AmbienceFootsteps    # เสียงบรรยากาศ/ฝีเท้า

var player_inside: bool = false
var pan_on: bool = true                          # เริ่มเปิดเตาอยู่

func _ready() -> void:
	# กระทะ: เปิดวนตั้งแต่ต้น

	if not pan_sizzle.playing:
		pan_sizzle.play()

	# ambience: ไม่ให้ดังตั้งแต่เข้า ฉากนี้คุมเองตอนปิดเตา

	ambience.stop()

	prompt.visible = false
	body_entered.connect(_on_enter)
	body_exited.connect(_on_exit)

func _on_enter(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = true
		prompt.visible = true
		prompt.text = "กด E ปิดเตา"

func _on_exit(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = false
		prompt.visible = false

func _process(_dt: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		if pan_on:
			_turn_off_pan()
		# ถ้าไม่อยากให้เปิดได้อีก ก็ตัด else ทิ้งไปเลย
		# else:
		#     _turn_on_pan()

func _turn_off_pan() -> void:
	pan_on = false
	prompt.visible = false

	pan_sizzle.stop()                                   # หยุดกระทะทันที
	if close_sfx and close_sfx.stream:
		close_sfx.play()                                # เล่นเสียงปิด (ถ้ามีไฟล์)

	if not ambience.playing:
		ambience.play()                                 # ให้ ambience ดัง "ทันที"

# (ออปชัน) ถ้าภายหลังอยากสลับเปิด-ปิดได้ ให้ปลดคอมเมนต์ฟังก์ชันนี้และบล็อก else ข้างบน
# func _turn_on_pan() -> void:
#     pan_on = true
#     prompt.visible = true
#     prompt.text = "กด E ปิดเตา"
#     if ambience.playing:
#         ambience.stop()
#     pan_sizzle.play()
