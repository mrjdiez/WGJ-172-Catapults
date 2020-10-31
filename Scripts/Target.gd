extends Area2D

signal target_hitted(score)

onready var Rock = preload("res://Objects/Rock.tscn")

export var min_score = 10
export var max_score = 100
export var scale_rate = 0.003

var score = null


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	self.score = randi() % max_score + min_score
	$Label.text = str(self.score)
	var scale_offset = self.score * self.scale_rate
	self.scale = Vector2(self.scale.x - scale_offset, self.scale.y - scale_offset)

	
func destroy():
	self.queue_free()

func end_game():
	queue_free()

func _on_Target_body_entered(body):
	self.destroy()
	body.hit()
	emit_signal("target_hitted", self.score)
