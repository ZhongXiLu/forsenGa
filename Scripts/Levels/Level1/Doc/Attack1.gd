extends "res://Scripts/Levels/Attack.gd"

export var initial_bullet_speed = 200
export var bullet_speed = 3000

var bullet = preload("res://Scenes/ObjectScenes/Levels/Level1/Doc/CD.tscn")
var bullet_instances = []

func _ready():
    
    $AudioStreamPlayer.play()
    
    # Where to instantiate the bullets => outside the sprite
    var sprite_size_offset = get_node("../../AnimatedSprite").frames.get_frame("idle", 0).get_width() * 1.2
    
    var target_position_offsets = [
        [-400, 0, 400], [-400, -200, 200, 400], range(-450, 450, 100), range(-200, -2000, -100) + range(200, 2000, 100)
       ]
    target_position_offsets.shuffle()
    
    for target_position_offset in target_position_offsets:
        var bullet_instances = []
        for offset in target_position_offset:
            var bullet_instance = bullet.instance()
            bullet_instance.position.x = get_node("../../").global_position.x
            bullet_instance.position.y = get_node("../../").global_position.y + sprite_size_offset
            get_parent().add_child(bullet_instance)
            bullet_instance.set_linear_velocity(
                (Vector2(get_node("../../../Player").position.x + offset, get_node("../../../Player").position.y)
                - bullet_instance.position).normalized() * initial_bullet_speed
            )
            bullet_instances.append(bullet_instance)
            
        # Delay the attack a little bit, so the player has time to react
        yield(get_tree().create_timer(1, false), "timeout")
    
        # Speed the bullet up after delay
        var speed_factor = bullet_speed / initial_bullet_speed
        for bullet_instance in bullet_instances:
            if weakref(bullet_instance).get_ref():     # possible that bullet gets freed on creation
                bullet_instance.linear_velocity.x *= speed_factor
                bullet_instance.linear_velocity.y *= speed_factor
                
        yield(get_tree().create_timer(0.25, false), "timeout")
    
    queue_free()
