extends Node2D

# add the definitions here and then play them in other scripts with the functions
const BUTTON_DOWN = preload("res://audio/click_002.ogg")
const BUTTON_UP = preload("res://audio/click_003.ogg")
const ERROR = preload("res://audio/error_008.ogg")
const CONFIRMATION = preload("res://audio/confirmation_001.ogg")
const DROPPED_IN_POTION = preload("res://audio/maximize_008.ogg")
const START_BGM = preload("res://audio/Potion Shop BG Music #1.mp3")
const GAME_BGM = preload("res://audio/tunetank-jazz-cafe-music-348267.mp3")

@export var current_player = null

func _ready():
	EventBus.button_pressed.connect(_button_pressed)

# multiple sfx can play simultaniously, so they won't get overridden
func play_sfx(Stream, Volume, pitch = 1.0):
	var fx = AudioStreamPlayer.new()
	fx.stream = Stream
	fx.name = "audio effects player"
	fx.volume_db = Volume
	fx.pitch_scale = pitch
	add_child(fx)
	fx.play()
	await fx.finished
	fx.queue_free()

# only one song can play at a time, so if you call music, the old music will be overridden
func play_music(Stream, Volume, Loop):
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
	while Loop:
		musicPlayer.play()
		current_player = musicPlayer
		await musicPlayer.finished
	musicPlayer.queue_free()

func _button_pressed(isDown):
	if isDown:
		play_sfx(BUTTON_DOWN, 15)
	else:
		play_sfx(BUTTON_UP, 15)
