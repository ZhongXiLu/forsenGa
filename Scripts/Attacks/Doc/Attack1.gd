extends Node

export var initial_bullet_speed = 100
export var bullet_speed = 3000

var bullet = preload("res://Scenes/ObjectScenes/CD.tscn")
var bullet_instances = []

func _ready():
    
    $AudioStreamPlayer.play()
    
    # Where to instantiate the bullets => outside the sprite
    var sprite_size_offset = get_node("../../AnimatedSprite").frames.get_frame("idle", 0).get_width() * 1.2
    
    # Create 8 bullets in each direction + set initial speed
    var directions = [0, -1, 1]
    for direction in directions:
        for direction2 in directions:
            if direction != 0 or direction2 != 0:
                var bullet_instance = bullet.instance()
                bullet_instance.position.x = get_node("../../").global_position.x + (direction * sprite_size_offset)
                bullet_instance.position.y = get_node("../../").global_position.y + (direction2 * sprite_size_offset)
                add_child(bullet_instance)
                bullet_instance.set_linear_velocity(Vector2(direction * initial_bullet_speed, direction2 * initial_bullet_speed))
                bullet_instances.append(bullet_instance)
        
    # Delay the attack a little bit, so the player has time to react
    yield(get_tree().create_timer(1, false), "timeout")

    # Speed the bullet up after delay
    var speed_factor = bullet_speed / initial_bullet_speed
    for bullet_instance in bullet_instances:
        if weakref(bullet_instance).get_ref():     # possible that bullet gets freed on creation
            bullet_instance.linear_velocity.x *= speed_factor
            bullet_instance.linear_velocity.y *= speed_factor

func _process(_delta):
    if bullet_instances.empty():
        queue_free()        # attack is over
