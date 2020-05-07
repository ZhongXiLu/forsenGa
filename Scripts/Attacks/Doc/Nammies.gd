extends KinematicBody2D

export var gravity = 60
export var speed = 600
export var bullet_speed = 800
export var fire_rate = 0.05

var bullet = preload("res://Scenes/ObjectScenes/Doc/NaM.tscn")
var motion = Vector2()
var player_in_sight = false
var has_fired = false
onready var sprite_size_offset = $AnimatedSprite.frames.get_frame("idle", 0).get_width() * 1.2

func _ready():
    $AnimatedSprite.play()


func _physics_process(_delta):
    if !player_in_sight:
        if !$FloorEdge.is_colliding() or $WallEdge.is_colliding():
            scale.x = -1
            speed *= -1
    
        motion.y += gravity
        motion.x = speed
            
        motion = move_and_slide_with_snap(motion, Vector2(0, -1))


func _process(delta):
    if player_in_sight and !has_fired:
        has_fired = true
        var bullet_instance = bullet.instance()
        bullet_instance.position.x = global_position.x + (sign(rand_range(-1, 1)) * sprite_size_offset)
        bullet_instance.position.y = global_position.y - (rand_range(-0.5, 1.5) * sprite_size_offset)
        get_parent().add_child(bullet_instance)
        bullet_instance.set_linear_velocity(
            (bullet_instance.position - global_position).normalized() * bullet_speed
        )
        yield(get_tree().create_timer(fire_rate, false), "timeout")
        has_fired = false

func _on_Area2D_body_entered(body):
    if body.get_collision_layer_bit(1):     # player
        body.get_node("Stats").health -= 1


func _on_Stats_no_health():
    queue_free()

func player_in_sight(body):
    player_in_sight = true

func player_out_of_sight(body):
    player_in_sight = false
