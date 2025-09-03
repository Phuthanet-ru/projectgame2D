extends Area2D

@onready var closet_sound: AudioStreamPlayer2D = $ClosetSound
var player_inside := false

func _ready() -> void:
	# ให้เสียงลูปและเริ่มเล่นทันที (หรือจะติ๊ก Autoplay/Loop ใน Inspector ก็ได้)
	if not closet_sound.playing:
		closet_sound.play()

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = false

func _unhandled_input(event: InputEvent) -> void:
	if player_inside and event.is_action_pressed("interact"): # ปุ่ม E
		if closet_sound.playing:
			closet_sound.stop()
