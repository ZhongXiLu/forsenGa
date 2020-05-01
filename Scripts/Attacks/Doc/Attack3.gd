extends "res://Scripts/Attacks/Attack.gd"

export var bullet_speed = 1000

var bullet = preload("res://Scenes/ObjectScenes/Doc/CD.tscn")

func _ready():
    
    $AudioStreamPlayer.play()
    get_node("../../AnimatedSprite").play("attack3")
    
    # Where to instantiate the bullets => outside the sprite
    var sprite_size_offset = get_node("../../AnimatedSprite").frames.get_frame("idle", 0).get_width() * 1.2
    var old_position = get_node("../../").global_position
    
    for _i in range(35):
        var bullet_instance = bullet.instance()
        bullet_instance.position.x = old_position.x + (rand_range(-1.5, 1.5) * sprite_size_offset)
        bullet_instance.position.y = old_position.y + sprite_size_offset
        get_parent().add_child(bullet_instance)
        bullet_instance.set_linear_velocity(
            (bullet_instance.position - old_position).normalized() * bullet_speed
        )
        yield(get_tree().create_timer(0.1, false), "timeout")

    get_node("../../AnimatedSprite").play("idle")
    queue_free()
