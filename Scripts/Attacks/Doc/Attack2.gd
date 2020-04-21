extends Node

export var drop_speed = 1000
export var width_arena = 1100

var spam = preload("res://Scenes/ObjectScenes/Spam.tscn")
var spam_instances = []
var attack_finished = false

# Probably not a good idea to hardcode copy pasta's but eShrug
const COPY_PASTAS = [
    "Hey guys. uuuuuh... I kinda have a little bit of an announcement, I just wanna be completely transparent with you guys, as you guys know I have a beautiful family, and a wife, and kid. And I wanna be transparent that I've been unfaithful, and I'm probably going to be taking some time away, t-time off, to focus on... Stupid fucking mistakes man",
    "Let's talk about about me, let's talk about the 6'8 frame the 37 in verticle leap...the black steel that drapes down my back aka the bullet proof mullet, the google prototype scopes with built in LCD LED 1080p 3D sony technology. The Ethiopian poisonous catapillar aka SLICK DADDY. lets talk about the cabinets right behind me that go 40ft deep that house the other 95% of my trophies, the awards, the certificates, all claiming first place, right? Let me give you a little inside glimpse into the hotshot, video game life style of the two time of the international video game superstar. because thats what the channels about, thats what this domain is about, that is what society is about. you are looking at the new face of twitch and GODDAMN is twitch lucky... thats just off the top of my head",
    "Oh, is he spa- is he spamming one of those little baby precious attention... Ah- G- Hahahahaha! I writed the emote! Hahahhahaha- Twitter! Hihihi- Twitch chat! Hahahahahaehahaha- hey! Try to get some likes on my tweet! Hahahaa! Hahaha! Forsen, Forsen! I'm your number one fan, I get the- I spammed your little- hehaha CD! Hahahahahaha Hihihi Hahaahaha Hihihi Hahahaha! Tweet him! Hahaaaa Hahahahahaha!",
    "I'll repeat myself, used to think Forsen was atleast somewhat intelligent so he'd be understand this, but fuck it; The guy plays a character, yes some of the rage etc is real, but his whole schtick is trash talking alpha male whatever the fuck. He has been on the receiving end of harassment against him, while at the same time trying to fix his relationship with his wife. Obviously this will get to him. It affects both their private and public life. The whole 'Oh no, it was a dying meme, he should just have ignored it' sort of works, but not really. It wasn't a dying meme. People still kept spamming it every time he was mentioned, every time cheating came up, every time being transparant showed up. More and more streamers were making Doc emotes, that were specifically only there to harass him. If you want to attack him for being a cheating cunt, go ahead, but acting like you weren't doing anything wrong because he wanted to, atleast while streaming, pretend that it didn't bother him, is just... So fucking retarded. People bully him because they think it's funny, it hurts him, he's not an emotionless super stud like he pretends to be on stream. All this pretending about this shit is so fucking surreal. You know what you're doing, come the fuck on.",
    "Something about compact disks are transparent etc, etc. It's like you know, these little chubby cheek wannabe wannabes. Like, to laugh and giggle behind-the-scenes, right? That's what it stands for. Something about compact disks are transparent etc, etc. It's like you know, these little chubby cheek wannabe wannabes. Like, to laugh and giggle behind-the-scenes, right? That's what it stands for."
   ]


func _ready():
    
    $AudioStreamPlayer.play()
    
    for _i in range(2):
        var spam_instance = spam.instance()
        var target_position = Vector2(get_parent().global_position.x - randi() % width_arena + 1, get_parent().global_position.y - 600)
        spam_instance.position = target_position
        spam_instance.get_node("AnimatedSprite").play()
        add_child(spam_instance)
        yield(get_tree().create_timer(1), "timeout")
        spam_instance.get_node("CopyPasta").text = COPY_PASTAS[randi() % COPY_PASTAS.size()]
        spam_instance.get_node("AnimatedSprite").visible = false
        spam_instance.get_node("CopyPasta").visible = true
        spam_instance.set_linear_velocity(Vector2(0, drop_speed))
        spam_instances.append(spam_instance)
        yield(get_tree().create_timer(1), "timeout")

    attack_finished = true

func _process(_delta):
    if spam_instances.empty() and attack_finished:
        queue_free()        # attack is over
