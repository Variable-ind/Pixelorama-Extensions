extends Reference

var p_path: String
var dir_path: String

const STARTING = ("""<?xml version="1.0" standalone="no"?>
<mlt LC_NUMERIC="C" version="7.18.0" title="Shotcut version 23.07.29" producer="playlist0">
	<profile description="PAL 4:3 DV or DVD" width="1920" height="1080" progressive="1" sample_aspect_num="1" sample_aspect_den="1" display_aspect_num="16" display_aspect_den="9" frame_rate_num="60" frame_rate_den="1" colorspace="709"/>""")

var producers := []

const MIDDLE = ("""<playlist id="playlist0" title="Shotcut version 23.07.29">
	<property name="shotcut:projectAudioChannels">2</property>
	<property name="shotcut:projectFolder">1</property>""")

var entry := []

const END = ("""</playlist>
</mlt>""")


func compile():
	var final = STARTING
	for data in producers:
		final += data
	final += MIDDLE
	for data in entry:
		final += data
	final += END
	if p_path:
		var file = File.new()
		file.open(p_path, file.WRITE)
		file.store_string(final)
		file.close()


func add_item_to_playlist(path: String, clip_duration: float):
	if !p_path:
		p_path = path.replace(path.get_file(), "project.mlt")
	var raw = ("""	<producer id="<UNIQUE_ID>" in="00:00:00.000" out="<LENGTH>">
		<property name="length"><LENGTH></property>
		<property name="eof">pause</property>
		<property name="resource"><PATH></property>
		<property name="ttl">1</property>
		<property name="aspect_ratio">1</property>
		<property name="seekable">1</property>
		<property name="format">2</property>
		<property name="mlt_service">qimage</property>
		<property name="xml">was here</property>
	 </producer>""")
	var entry_raw = ("""	<entry producer="<UNIQUE_ID>" in="00:00:00.000" out="<LENGTH>"/>""")
	raw = raw.replace("<UNIQUE_ID>", str("producer", producers.size()))
	raw = raw.replace("<LENGTH>", calculate_duration(clip_duration))
	entry_raw = entry_raw.replace("<UNIQUE_ID>", str("producer", producers.size()))
	entry_raw = entry_raw.replace("<LENGTH>", calculate_duration(clip_duration))
	raw = raw.replace("<PATH>", path.get_file())
	producers.append(raw)
	entry.append(entry_raw)


func calculate_duration(clip_duration: float) -> String:
	var millis = clip_duration - floor(clip_duration)
	if millis > 0:
		var millis_test = str2var(str(millis).get_slice(".", 1))
		var adder = ""
		if millis_test < 100:
			adder = "0"
			if millis_test < 10:
				adder += "0"
		if millis < 0.1:
			millis = str(adder, millis_test)
		else:
			millis = str(millis_test, adder)
	else:
		millis = "000"
	var secs = floor(clip_duration)
	var minutes = floor(secs / 60.0)
	var hours = floor(minutes / 60.0)
	secs = int(secs) % 60
	minutes = int(minutes) % 60
	if secs < 10:
		secs = str("0", secs)
	if minutes < 10:
		minutes = str("0", minutes)
	if hours < 10:
		hours = str("0", hours)
	return str(hours, ":", minutes, ":", secs, ".", millis)
