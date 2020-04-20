extends AudioStreamPlayer


func _on_Player_Stats_no_health():
    stop()
    $PlayerDeath.play()

func _on_Boss_Stats_no_health():
    stop()
    $BossDeath.play()
