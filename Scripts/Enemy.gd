extends KinematicBody2D

export var gravity = 60
export var speed = 600

var motion = Vector2()

func _physics_process(_delta):
    
    if !$FloorEdge.is_colliding() or $WallEdge.is_colliding():
        scale.x = -1
        speed *= -1

    motion.y += gravity
    motion.x = speed
        
    motion = move_and_slide_with_snap(motion, Vector2(0, -1))


func _on_Area2D_body_entered(body):
    if body.get_collision_layer_bit(1):     # player
        body.get_node("Stats").health -= 1


func _on_Stats_no_health():
    queue_free()
