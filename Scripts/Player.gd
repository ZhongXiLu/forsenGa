extends KinematicBody2D

export var gravity = 60
export var max_speed = 600
export var acceleration = 80
export var jump_height = 1200

export var dash_speed = 1500
export var dash_rate = 0.6

export var bullet_speed = 5000
export var fire_rate = 0.5

const UP = Vector2(0, -1)   # which direction is "up"

var motion = Vector2()
var bullet = preload("res://Scenes/ObjectScenes/pepeL.tscn")
var can_fire = true
var can_dash = true     # possible to dash now (~dash rate)
var dashing = false     # player is currently dashing


func _process(_delta):
    
    if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_fire:
        var bullet_instance = bullet.instance()
        
        bullet_instance.rotation = (get_angle_to(get_global_mouse_position()) + rotation)
        if bullet_instance.rotation > 1.5 or bullet_instance.rotation < -1.5:
            bullet_instance.get_node("Sprite").flip_v = true
        
        bullet_instance.position = global_position
        get_parent().add_child(bullet_instance)
        bullet_instance.set_linear_velocity((get_global_mouse_position() - global_position).normalized() * bullet_speed)
        
        can_fire = false
        yield(get_tree().create_timer(fire_rate, false), "timeout")
        can_fire = true
        
    if Input.is_mouse_button_pressed(BUTTON_LEFT):
        $AnimatedSprite.play("shooting")
    else:
        $AnimatedSprite.play("idle")
    

func _physics_process(_delta):
    
    if !dashing:
        var friction = false
        motion.y += gravity
        if Input.is_action_pressed("ui_right"):
            motion.x = min(motion.x + acceleration, max_speed)
            $AnimatedSprite.flip_h = false
        elif Input.is_action_pressed("ui_left"):
            motion.x = max(motion.x - acceleration, -max_speed)
            $AnimatedSprite.flip_h = true
        else:
            friction = true
        
        if is_on_floor():
            if Input.is_action_pressed("ui_up"):
                motion.y = -jump_height
            if friction:
                motion.x = lerp(motion.x, 0, 0.1)
        else:
            if friction:
                motion.x = lerp(motion.x, 0, 0.05)
                
        if Input.is_action_just_pressed("dash") and can_dash:
            can_dash = false
            dashing = true
            motion.x = sign(motion.x) * dash_speed
            motion.y = 0
            yield(get_tree().create_timer(0.2, false), "timeout")
            dashing = false
            yield(get_tree().create_timer(dash_rate, false), "timeout")
            can_dash = true
        
    motion = move_and_slide(motion, UP)


func _on_Stats_no_health():
    # TODO: player died
    print("Player died!")
