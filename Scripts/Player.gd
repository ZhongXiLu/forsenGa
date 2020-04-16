extends KinematicBody2D

const UP = Vector2(0, -1)   # which direction is "up"
const GRAVITY = 60
const MAX_SPEED = 600
const ACCELERATION = 80
const JUMP_HEIGHT = 1200

var motion = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    
    var friction = false
    motion.y += GRAVITY
    if Input.is_action_pressed("ui_right"):
        motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
        $Sprite.flip_h = false
    elif Input.is_action_pressed("ui_left"):
        motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
        $Sprite.flip_h = true
    else:
        friction = true
    
    if is_on_floor():
        if Input.is_action_pressed("ui_up"):
            motion.y = -JUMP_HEIGHT
        if friction:
            motion.x = lerp(motion.x, 0, 0.1)
    else:
        if friction:
            motion.x = lerp(motion.x, 0, 0.05)
    
    motion = move_and_slide(motion, UP)
