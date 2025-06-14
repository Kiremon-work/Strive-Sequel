extends Node
var floatfont = preload("res://FloatFont.tres")

var BeingAnimated = []
var ShakingNodes = []
var gfx_sprite_timing = {}

func _process(delta):
	for i in ShakingNodes:
		if i.time > 0:
			i.time -= delta
			i.node.rect_position = i.originpos + Vector2(rand_range(-1.0,1.0)*i.magnitude, rand_range(-1.0,1.0)*i.magnitude)
		else:
			i.node.rect_position = i.originpos
			ShakingNodes.erase(i)

#some of those are not used now
func SelectionGlow(node):
	if !node.is_inside_tree(): return
	var tween = input_handler.GetRepeatTweenNode(node)
	tween.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,0.5,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'modulate', Color(1,0.5,1,1), Color(1,1,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,1)
	tween.start()

func TargetGlow(node):
	if !node.is_inside_tree(): return
	var tween = input_handler.GetRepeatTweenNode(node)
	tween.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,0.8,0.3,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'modulate', Color(1,0.8,0.3,1), Color(1,1,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,1)
	tween.start()

func TargetSupport(node):
	if !node.is_inside_tree(): return
	var tween = input_handler.GetRepeatTweenNode(node)
	tween.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(0.5,1,0.5,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'modulate', Color(0.5,1,0.5,1), Color(1,1,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,1)
	tween.start()

func TargetEnemyTurn(node):
	if !node.is_inside_tree(): return
	var tween = input_handler.GetRepeatTweenNode(node)
	tween.interpolate_property(node, 'rect_scale', Vector2(1,1), Vector2(1.05,1.05), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'rect_scale', Vector2(1.05,1.05), Vector2(1,1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,0.5)
	tween.start()

func FloatTextArgs(args):
	#print('ftchecked')
	FloatText(args.node, args.text, args.type, args.size, args.color, args.time, args.fadetime, args.offset)

func FloatText(node, text, type = '', size = 80, color = Color(1,1,1), time = 3, fadetime = 0.5, positionoffset = Vector2(0,0)):
	if !node.is_inside_tree(): return
	var textnode = Label.new()
	node.add_child(textnode)
	var newfont = floatfont.duplicate()
	newfont.size = size
	textnode.set("custom_fonts/font", newfont)
	textnode.text = text
	textnode.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	textnode.rect_position += positionoffset

	textnode.set("custom_colors/font_color", color)
	textnode.set("custom_colors/font_color_shadow", Color(0,0,0))

	match type:
		'damageenemy':
			DamageTextFly(textnode, false)
		'damageally':
			DamageTextFly(textnode, true)
		'miss':
			FadeAnimation(textnode, fadetime, time)
		"heal":
			DamageTextFly(textnode, false)
#			HealTextFly(textnode)
	#FadeAnimation(textnode, fadetime, time)
#	node.remove_child(textnode)
#	get_tree().get_current_scene().add_child(textnode)
	var wr = weakref(textnode)
	yield(get_tree().create_timer(time+1), 'timeout')
	if wr.get_ref(): textnode.queue_free()

func DamageTextFly(node, reverse = false):
	if !node.is_inside_tree(): return
	var tween = input_handler.GetTweenNode(node)
#	var firstvector = Vector2(100, -100)
#	var secondvector = Vector2(200, 200)
#	if reverse == true:
#		firstvector = Vector2(-100, -100)
#		secondvector = Vector2(-200, 200)
#	yield(get_tree().create_timer(0.5), 'timeout')
#	tween.interpolate_property(node, 'rect_position', node.rect_position, node.rect_position+firstvector, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	tween.interpolate_property(node, 'rect_position', node.rect_position+firstvector, node.rect_position+secondvector, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.3)
#	FadeAnimation(node, 0.2 , 0.7)
	var firstvector = Vector2(0, 0)
	tween.interpolate_property(node, 'rect_position', node.rect_position, node.rect_position+firstvector, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,0.5)
	FadeAnimation(node, 0.2, 1)
	tween.start()

func HealTextFly(node):
	if !node.is_inside_tree(): return
	var tween = input_handler.GetTweenNode(node)
	var firstvector = Vector2(0, -150)
	tween.interpolate_property(node, 'rect_position', node.rect_position, node.rect_position+firstvector, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,0.5)
	FadeAnimation(node, 0.2, 1)
	tween.start()

func OpenAnimation(node, speed = 0.2, transition_type = Tween.TRANS_LINEAR, ease_type = Tween.EASE_IN_OUT):
	if !node.is_inside_tree(): return
	if BeingAnimated.has(node) == true:
		return
	node.raise()
	BeingAnimated.append(node)
	node.visible = true
	var tweennode = input_handler.GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,0), Color(1,1,1,1), speed, transition_type, ease_type)
	tweennode.start()
	yield(get_tree().create_timer(speed - 0.05), 'timeout')
	BeingAnimated.erase(node)
	

func CloseAnimation(node, speed = 0.2, transition_type = Tween.TRANS_LINEAR, ease_type = Tween.EASE_IN_OUT):
	if !node.is_inside_tree(): return
#	var t1 = OS.get_ticks_msec()
	if BeingAnimated.has(node) == true:
#		print("a_skipped")
		return
	BeingAnimated.append(node)
	var tweennode = input_handler.GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), speed, transition_type, ease_type)
#	print("a_start " + str(OS.get_ticks_msec()))
	tweennode.start()
#	var t2 = OS.get_ticks_msec()
	yield(get_tree().create_timer(speed - 0.05), 'timeout')
#	yield(tweennode, 'tween_completed')
#	var t3 = OS.get_ticks_msec()
	node.visible = false
	BeingAnimated.erase(node)
#	print("%d: %d - %d" % [t1, t2, t3])

func OldOpenAnimation(node):
	if !node.is_inside_tree(): return
	if BeingAnimated.has(node) == true:
		return
	BeingAnimated.append(node)
	node.visible = true
	var tweennode = input_handler.GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,0), Color(1,1,1,1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.interpolate_property(node, 'rect_scale', Vector2(0.7,0.6), Vector2(1,1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.start()
	yield(get_tree().create_timer(0.3), 'timeout')
	BeingAnimated.erase(node)

func OldCloseAnimation(node):
	if !node.is_inside_tree(): return
	if BeingAnimated.has(node) == true:
		return
	BeingAnimated.append(node)
	var tweennode = input_handler.GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.interpolate_property(node, 'rect_scale', Vector2(1,1), Vector2(0.7,0.6), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.start()
	yield(get_tree().create_timer(0.3), 'timeout')
	node.visible = false
	BeingAnimated.erase(node)

func FadeAnimation(node, time = 0.3, delay = 0):
#	var t1 = OS.get_ticks_msec()
#	if BeingAnimated.has(node) == true:
#		return
	#BeingAnimated.append(node)
#	print(node.get_parent().name)
	if !node.is_inside_tree(): return
	var tweennode = input_handler.GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tweennode.start()
	#BeingAnimated.erase(node)

func UnfadeAnimation(node, time = 0.3, delay = 0):
#	var t1 = OS.get_ticks_msec()
	if !node.is_inside_tree(): return
	if BeingAnimated.has(node) == true:
		return
	BeingAnimated.append(node)
	var tweennode = input_handler.GetTweenNode(node)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,0), Color(1,1,1,1), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
#	var t2 = OS.get_ticks_msec()
	tweennode.start()
	yield(tweennode, 'tween_completed')
#	var t3 = OS.get_ticks_msec()
	BeingAnimated.erase(node)
#	print("%d: %d - %d" % [t1, t2, t3])


func UnshadeAnimation(node, time = 0.3, delay = 0):
	if !node.is_inside_tree(): return
	var tweennode = input_handler.GetTweenNode(node)
	tweennode.interpolate_property(node.get_material(), 'shader_param/opacity', 1.0, 0.0, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tweennode.start()


func ShadeAnimation(node, time = 0.3, delay = 0):
	if !node.is_inside_tree(): return
	var tweennode = input_handler.GetTweenNode(node)
	tweennode.interpolate_property(node.get_material(), 'shader_param/opacity', 0.0, 1.0, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tweennode.start()


func ShakeAnimation(node, time = 0.5, magnitude = 5):
	if !node.is_inside_tree(): return
	var newdict = {node = node, time = time, magnitude = magnitude, originpos = node.rect_position}
	for i in ShakingNodes:
		if i.node == node:
			newdict.originpos = i.originpos
			ShakingNodes.erase(i)
	ShakingNodes.append(newdict)

func SmoothValueAnimation(node, time, value1, value2):
	if !node.is_inside_tree(): return
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_property(node, 'value', value1, value2, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func gfx(node, effect, fadeduration = 0.5, delayuntilfade = 0.3, flip = false,  rotate = false):
	if !node.is_inside_tree(): return
	var x = TextureRect.new()
	x.texture = images.GFX[effect]
	x.expand = true
	x.stretch_mode = 6
	x.mouse_filter = 2
	node.add_child(x)

	x.rect_size = node.rect_size

	if flip: x.set_flip_h(true)

	if rotate == true:
		x.rect_pivot_offset = images.GFX[effect].get_size()/2
		x.rect_rotation = rand_range(0,360)

	self.FadeAnimation(x, fadeduration, delayuntilfade)
	var wr = weakref(x)
	yield(get_tree().create_timer(fadeduration*2), 'timeout')

	if wr.get_ref(): x.queue_free()

func gfx_sprite(node, effect, fadeduration = 0.5, delayuntilfade = 0.3, flip = false):
	if !node.is_inside_tree(): return
	var x = load(images.GFX_sprites[effect]).instance()
	node.add_child(x)
	x.position = node.rect_size/2
	if flip == true: x.set_flip_h(true)
	#x.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	x.play()

	self.FadeAnimation(x, fadeduration, delayuntilfade)
	var wr = weakref(x)
	yield(get_tree().create_timer(delayuntilfade+fadeduration), 'timeout')

	if wr.get_ref(): x.queue_free()

func gfx_particles(node, effect, fadeduration = 0.5, delayuntilfade = 0.3):
	if !node.is_inside_tree(): return
	var x = load(images.GFX_particles[effect]).instance()
	node.add_child(x)
	x.position = node.rect_size/2
	#x.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	x.emitting = true

	self.FadeAnimation(x, fadeduration, delayuntilfade)
	var wr = weakref(x)
	yield(get_tree().create_timer(fadeduration*2), 'timeout')

	if wr.get_ref(): x.queue_free()


func gfx_particles_infinite(node, effect):
	if !node.is_inside_tree(): return
	var x = load(images.GFX_particles[effect]).instance()
	node.add_child(x)
	x.position = node.rect_size/2
	#x.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	x.emitting = true


func gfx_video(node, effect, fadeduration = 0.5, delayuntilfade = 0.3, flip = false):
	if !node.is_inside_tree(): return
	var x = load(images.GFX_video[effect]).instance()
	node.add_child(x)
	var video_size = x.get_video_texture().get_size()
#	if video_size.x == 0:
#		video_size.x = 200
	x.rect_size = Vector2(node.rect_size.x,
		video_size.y * (node.rect_size.x / video_size.x))
	x.rect_position.y = node.rect_size.y * 0.5 - x.rect_size.y * 0.5
#	if flip == true: x.set_flip_h(true)
	x.play()

	self.FadeAnimation(x, fadeduration, delayuntilfade)
	var wr = weakref(x)
	yield(get_tree().create_timer(delayuntilfade+fadeduration), 'timeout')

	if wr.get_ref(): x.queue_free()


func ResourceGetAnimation(node, startpoint, endpoint, time = 0.5, delay = 0.2):
	if !node.is_inside_tree(): return
	var tweennode = input_handler.GetTweenNode(node)
	tweennode.interpolate_property(node, 'rect_position', startpoint, endpoint, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tweennode.interpolate_property(node, 'modulate', Color(1,1,1,1), Color(1,1,1,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay + (time/1.2))
	tweennode.start()

func SmoothTextureChange(node, newtexture, time = 0.5):
	if !node.is_inside_tree(): return
	var NodeCopy = node.duplicate()
	node.get_parent().add_child_below_node(node, NodeCopy)
	node.texture = newtexture
	FadeAnimation(NodeCopy, time)
	yield(get_tree().create_timer(time+0.1), 'timeout')
	NodeCopy.queue_free()

func BlackScreenTransition(duration = 0.5):
	var blackscreen = load(ResourceScripts.scenedict.black).instance()
	get_tree().get_root().add_child(blackscreen)
	UnfadeAnimation(blackscreen, duration)
	FadeAnimation(blackscreen, duration, duration)
	yield(get_tree().create_timer(duration*2+0.1), 'timeout')
	blackscreen.queue_free()

func GameOverScreen():
	var duration = 4
	var blackscreen = load(ResourceScripts.scenedict.black).instance()
	blackscreen.get_node("Label").show()
	get_tree().get_root().add_child(blackscreen)
	UnfadeAnimation(blackscreen, duration)
	#FadeAnimation(blackscreen, duration, duration)
	yield(get_tree().create_timer(duration*2+0.1), 'timeout')
	blackscreen.queue_free()

func WhiteScreenTransition(duration = 0.5):
	var whitescreen = load(ResourceScripts.scenedict.white).instance()
	get_tree().get_root().add_child(whitescreen)
	UnfadeAnimation(whitescreen, duration)
	FadeAnimation(whitescreen, duration, duration)
	yield(get_tree().create_timer(duration*2+0.1), 'timeout')
	whitescreen.queue_free()

func DelayedText(node, text):
	node.text = text

func get_gfx_sprite_time(sprite_name):
	if !gfx_sprite_timing.has(sprite_name):
		var node = load(images.GFX_sprites[sprite_name]).instance()
		var sprite_frames = node.frames
		if !sprite_frames.has_animation('default'):
			print("Error! %s animation has no default animation!" % sprite_name)
			return 1
		gfx_sprite_timing[sprite_name] = sprite_frames.get_frame_count('default')/sprite_frames.get_animation_speed('default')
	
	return gfx_sprite_timing[sprite_name]




