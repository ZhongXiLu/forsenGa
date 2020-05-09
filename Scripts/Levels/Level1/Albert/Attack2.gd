extends "res://Scripts/Levels/Attack.gd"


export var bullet_speed = 600

const POSITIONS = [-1000, 3500]    # left and right to the arena
var bullet = preload("res://Scenes/ObjectScenes/Doc/Card.tscn")

func _ready():
    
    $AudioStreamPlayer.play()
    
    var parent = get_node("../../")
    
    # Where to instantiate the bullets => outside the sprite
    var sprite_size_offset = get_node("../../Sprite").texture.get_size().y * 1.2
    
    var bullet_instance = bullet.instance()
    bullet_instance.position.x = parent.global_position.x - + sprite_size_offset
    bullet_instance.position.y = parent.global_position.y
    get_parent().add_child(bullet_instance)
    bullet_instance.set_linear_velocity(Vector2(-bullet_speed, 0))
    
    yield(get_tree().create_timer(1.5, false), "timeout")
    
    # Fire card from left or right
    var rand_position = POSITIONS[randi() % POSITIONS.size()]
    bullet_instance.set_linear_velocity(Vector2(bullet_speed * 2, 0) * sign(rand_position) * -1)
    bullet_instance.global_position.x = rand_position
    bullet_instance.global_position.y = get_tree().root.get_node("World/Player").position.y
    
    queue_free()
