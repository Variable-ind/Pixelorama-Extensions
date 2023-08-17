extends AudioStreamPlayer

var timer: Timer
var end_time: float

func start(current_frame: int, tag: AnimationTag, streamer: AudioStream):
	var project = ExtensionsApi.project.get_current_project()
	timer = ExtensionsApi.general.get_global().animation_timer

	name = tag.name
	var start = tag.from

	var start_time: float = 0
	for frame_idx in range(tag.from - 1, tag.to):
		var frame: Frame = project.frames[frame_idx]
		var duration = frame.duration * (1.0 / project.fps)
		if frame_idx < current_frame:
			start_time += duration
		else:
			end_time += duration
	if streamer:
		stream = streamer
		$Timer.wait_time = end_time
		$Timer.start()
		play(start_time)


func _on_AudioController_finished() -> void:
	queue_free()

func _on_Timer_timeout() -> void:
	stop()
