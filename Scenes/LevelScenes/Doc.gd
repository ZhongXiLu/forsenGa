extends KinematicBody2D

export var bullet_speed = 2500
export var fire_rate = 0.5

var bullet = preload("res://Scenes/ObjectScenes/CD.tscn")
var can_fire = true
    

func _process(delta):
    if can_fire:
        can_fire = false

        var bullet_instance = bullet.instance()
        bullet_instance.position = global_position
        get_parent().add_child(bullet_instance)
        bullet_instance.set_linear_velocity(Vector2(0, 5))
            
        # Delay the attack a little bit, so the player has time to react
        yield(get_tree().create_timer(1), "timeout")
    
        bullet_instance.set_linear_velocity(Vector2(0, bullet_speed))

        yield(get_tree().create_timer(fire_rate), "timeout")
        can_fire = true
