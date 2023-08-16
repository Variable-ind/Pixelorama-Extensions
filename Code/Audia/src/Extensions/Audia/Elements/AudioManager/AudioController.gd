extends AudioStreamPlayer

var timer: Timer
var end_time: float
var _elapsed_time: float = 0


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

	timer.connect("timeout", self, "increase_delta")
	if streamer:
		stream = streamer
		play(start_time)


func _on_AudioController_finished() -> void:
	queue_free()


func increase_delta():
	_elapsed_time += timer.wait_time
	if _elapsed_time >= end_time or _elapsed_time >= stream.get_length():
		stop()
