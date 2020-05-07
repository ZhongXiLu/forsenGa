extends KinematicBody2D

export var gravity = 60
export var speed = 700
export var jump_height = 1250

var motion = Vector2()
var player_in_sight = false

func _ready():
    $AnimatedSprite.play()


func _physics_process(_delta):
    if is_on_floor() and player_in_sight:
        motion.y = -jump_height
        motion.x = speed
        motion.x *= sign((get_tree().root.get_node("World/Player").global_position.x) - global_position.x)
        
    motion.y += gravity
        
    motion = move_and_slide(motion, Vector2(0, -1))


func _process(delta):
    if player_in_sight:
        pass

func _on_Area2D_body_entered(body):
    if body.get_collision_layer_bit(1):     # player
        body.get_node("Stats").health -= 1


func _on_Stats_no_health():
    queue_free()

func player_in_sight(body):
    player_in_sight = true

func player_out_of_sight(body):
    player_in_sight = false
