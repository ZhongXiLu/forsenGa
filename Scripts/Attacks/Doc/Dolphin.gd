extends KinematicBody2D

export var speed = 10
export var bullet_speed = 1000
export var target_position = -100
export var destroy = false
export var rngs = [0, 1]

var motion = Vector2()
var bullet = preload("res://Scenes/ObjectScenes/Doc/WaterBall.tscn")
var bullet2 = preload("res://Scenes/ObjectScenes/Doc/WaterBall2.tscn")
var is_attacking = false
onready var player = get_tree().root.get_node("World/Player")
var direction = 1

func fire(fire_position):
    var bullet_instance = bullet.instance()
    get_parent().add_child(bullet_instance)
    bullet_instance.global_position = fire_position
    if direction == 1:
        bullet_instance.get_node("Sprite").flip_h = true
    bullet_instance.set_linear_velocity(Vector2(direction * bullet_speed, 0))

func _process(_delta):

    if abs(global_position.y - target_position) <= 5 and !destroy and !is_attacking:
        is_attacking = true
        
        direction = sign(player.position.x - global_position.x)
        
        # Attack 1
        fire(Vector2(global_position.x, player.global_position.y))
        yield(get_tree().create_timer(1, false), "timeout")
        
        # Attack 2
        for _i in range(3):
            if direction == rngs[0]:
                fire(Vector2(global_position.x, global_position.y + 100))
            else:
                fire(Vector2(global_position.x, global_position.y - 100))
            yield(get_tree().create_timer(0.1, false), "timeout")
        yield(get_tree().create_timer(0.7, false), "timeout")
        
        # Attack 3
        for _i in range(6):        
            var bullet_instance = bullet2.instance()
            get_parent().add_child(bullet_instance)
            bullet_instance.direction = direction
            bullet_instance.global_position.x = global_position.x
            if rngs[1] == 0:
                bullet_instance.is_cos = true
                bullet_instance.global_position.y = global_position.y + 50
            else:
                bullet_instance.is_cos = false
                bullet_instance.global_position.y = global_position.y - 150
            if direction == 1:
                bullet_instance.get_node("Sprite").flip_h = true
            yield(get_tree().create_timer(0.05, false), "timeout")
        yield(get_tree().create_timer(0.85, false), "timeout")
        
        is_attacking = false

func _physics_process(_delta):
    
    if global_position.y >= target_position and !destroy:
        motion.y -= speed
    elif destroy:
        motion.y += 3 * speed
    else:
        motion = Vector2.ZERO
    motion = move_and_slide(motion, Vector2(0, -1))

func _on_Area2D_body_entered(body):
    if body.has_node("Stats"):
        body.get_node("Stats").health -= 1
    if destroy:
        queue_free()
