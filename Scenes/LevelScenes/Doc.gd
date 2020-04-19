extends KinematicBody2D

export var initial_bullet_speed = 50
export var bullet_speed = 2500
export var fire_rate = 2

var bullet = preload("res://Scenes/ObjectScenes/CD.tscn")
var can_fire = true
var dead = false


func _process(delta):
    if can_fire and !dead:
        can_fire = false
        
        var bullet_instances = []
        
        # Where to instantiate the bullets => outside the sprite
        var sprite_size_offset = $AnimatedSprite.frames.get_frame("idle", 0).get_width() * 1.2
        
        # Create 8 bullets in each direction + set initial speed
        var directions = [0, -1, 1]
        for direction in directions:
            for direction2 in directions:
                if direction != 0 or direction2 != 0:
                    var bullet_instance = bullet.instance()
                    bullet_instance.position.x = global_position.x + (direction * sprite_size_offset)
                    bullet_instance.position.y = global_position.y + (direction2 * sprite_size_offset)
                    get_parent().add_child(bullet_instance)
                    bullet_instance.set_linear_velocity(Vector2(direction * initial_bullet_speed, direction2 * initial_bullet_speed))
                    bullet_instances.append(bullet_instance)
            
        # Delay the attack a little bit, so the player has time to react
        yield(get_tree().create_timer(1), "timeout")
    
        # Speed the bullet up after delay
        var speed_factor = bullet_speed / initial_bullet_speed
        for bullet_instance in bullet_instances:
            bullet_instance.linear_velocity.x *= speed_factor
            bullet_instance.linear_velocity.y *= speed_factor

        yield(get_tree().create_timer(fire_rate), "timeout")
        can_fire = true


func _physics_process(_delta):
    # Fall down to the ground if dead
    if dead:
        move_and_collide(Vector2(0, 5))


func _on_Stats_no_health():
    dead = true
    $AnimatedSprite.play("dead")
