extends KinematicBody2D

export(Array, Resource) var attacks = []

export var attack_rate = 5

var can_attack = false
var dead = false


func _ready():
    $Introduction.play()
    yield(get_tree().create_timer(5), "timeout")
    can_attack = true


func _process(delta):
    if can_attack and !dead:
        can_attack = false

        if attacks:
            add_child(attacks[0].instance())

        yield(get_tree().create_timer(attack_rate), "timeout")
        can_attack = true


func _physics_process(_delta):
    # Fall down to the ground if dead
    if dead:
        move_and_collide(Vector2(0, 5))


func _on_Stats_no_health():
    dead = true
    $AnimatedSprite.play("dead")
