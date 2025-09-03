extends Area2D

@onready var water: AudioStreamPlayer2D = $WaterSound
@onready var prompt: Label = $Prompt

@export var interact_action := "interact"

var player_inside := false
var water_on := true

func _ready() -> void:
	# ให้แน่ใจว่าเริ่มดังและวน
	if not water.playing:
		water.play()

	prompt.visible = false

	# ต่อสัญญาณเข้าออกโซน
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = true
		prompt.visible = true
		print("Player ENTER sink zone")

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = false
		prompt.visible = false
		print("Player EXIT sink zone")

func _process(_delta: float) -> void:
	# ใช้ just_pressed จะอ่านง่าย/กันกดค้าง
	if player_inside and Input.is_action_just_pressed(interact_action):
		if water_on:
			water.stop()
			water_on = false
			if is_instance_valid(prompt):
				prompt.text = "กด E เปิดน้ำ"
			print("Water OFF")
		else:
			water.play()
			water_on = true
			if is_instance_valid(prompt):
				prompt.text = "กด E ปิดน้ำ"
			print("Water ON")
