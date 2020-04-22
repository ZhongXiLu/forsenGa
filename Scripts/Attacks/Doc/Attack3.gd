extends Node

export var bullet_speed = 1000

var bullet = preload("res://Scenes/ObjectScenes/CD.tscn")
var bullet_instances = []

func _ready():
    
    $AudioStreamPlayer.play()
    get_parent().get_node("AnimatedSprite").play("attack3")
    
    # Where to instantiate the bullets => outside the sprite
    var sprite_size_offset = get_parent().get_node("AnimatedSprite").frames.get_frame("idle", 0).get_width() * 1.2
    var old_position = get_parent().global_position
    
    # TODO: make the Doc move across the screen?
    
    for _i in range(30):
        var bullet_instance = bullet.instance()
        bullet_instance.position.x = old_position.x + (rand_range(-1.5, 1.5) * sprite_size_offset)
        bullet_instance.position.y = old_position.y + sprite_size_offset
        add_child(bullet_instance)
        bullet_instance.set_linear_velocity(
            (bullet_instance.position - old_position).normalized() * bullet_speed
        )
        bullet_instances.append(bullet_instance)
        yield(get_tree().create_timer(0.1), "timeout")

    get_parent().get_node("AnimatedSprite").play("idle")

func _process(_delta):
    if bullet_instances.empty():
        queue_free()        # attack is over