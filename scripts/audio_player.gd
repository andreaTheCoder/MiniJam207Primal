extends Node2D

#add SFX definitions here and then play the sfx in other scripts with the functions
#for example const CLICK = preload("res://audio/clicksound.mp3")

# the difference between playing music and SFX is that
# only one song can play at a time so if you call the music 
# it will override the other one but the sfx can play
# simultaneously

func play_sfx(Stream, Volume):
	var fx = AudioStreamPlayer.new()
	fx.stream = Stream
	fx.name = "audio effects player"
	fx.volume_db = Volume
	add_child(fx)
	fx.play()
	await fx.finished
	
	fx.queue_free()

var current_player = null

func play_music(Stream, Volume):

	if current_player:
		if Stream == current_player.stream:
			return
		current_player.queue_free()
	var musicPlayer = AudioStreamPlayer.new()
	musicPlayer.stream = Stream
	musicPlayer.name = "music player"
	musicPlayer.volume_db = Volume
	add_child(musicPlayer)
	musicPlayer.play()
	current_player = musicPlayer
	await musicPlayer.finished

	musicPlayer.queue_free()
	
