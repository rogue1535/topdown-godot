extends Area2D

@export var moltov = preload("res://burn.tscn")
@export var speed = 100
var direct = Vector2(0,0)
var velocity = Vector2.ZERO

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rotation += 7*delta
	position += velocity.normalized() * delta * speed


func _on_timer_timeout():
	var fire= moltov.instantiate()
	get_parent().add_child(fire)
	fire.position = self.position
	queue_free()


func _on_body_entered(body):
	if body.has_method('handle_hit'):
		body.handle_hit()
		var fire= moltov.instantiate()
		$"..".add_child(fire)
		fire.position = self.position
		queue_free()
