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
		prompt.text = "กด E หยุด" if sound_on else "กด E เคาะกรอบรูป"

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = false
		prompt.visible = false

func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		if sound_on:
			frame_sound.stop()
			close_sfx.play()  # 👈 เล่นเสียงตอนปิด
			sound_on = false
			prompt.text = "กด E เคาะกรอบรูป"
		else:
			frame_sound.play()
			sound_on = true
			
