extends RigidBody2D


func _on_Bullet_body_entered(body):
    
    # Check if collided object has stats (i.e. health)
    var stats = body.get_node("Stats")
    if stats:
        stats.health -= 1
        
    queue_free()
