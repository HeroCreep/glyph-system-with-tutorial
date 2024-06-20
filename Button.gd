extends Node2D

var lstNodeClicked = 0
var arrNodeClicked = []
var posButton = [Vector2(0, 0), Vector2(9, 15.5), Vector2(9, 82.5), Vector2(84, 15.5), Vector2(84, 82.5), Vector2(49, 125.5)]
var arrLine = []
var arrMagic = [[1, 3, 4, 5, 2, 1]]

var incorrect = ["Please draw the correct shape to continue!"]
var correct = ["Great!", "Good job!"]
var tutorialFinished = "Hurray! Tutorial finsihed!"
var start = ["Welcome", "To progress in the game you need to draw the correct shape!", "Let's begin, shall we?"]
var spells = [
	"12345",
	"54321",
	"13524"
]

var current_spell

var current_combo = []

var pos = 0

var can_click = true

var dialog

var correct_combos = 0

var is_start_dialog = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _draw():
	var white = Color.WHITE
	for arr in arrLine:
		draw_line(arr[0], arr[1], white, 6.0)


func on_button_pressed(id):
	#if lstNodeClicked == id: return
	arrNodeClicked.append(id)
	print(arrNodeClicked)
	if lstNodeClicked != 0:
		arrLine.append([posButton[lstNodeClicked], posButton[id]])
		queue_redraw()
	lstNodeClicked = id


func _on_button_1_pressed():
	on_button_pressed(1)


func _on_button_2_pressed():
	on_button_pressed(2)


func _on_button_3_pressed():
	on_button_pressed(3)


func _on_button_4_pressed():
	on_button_pressed(4)


func _on_button_5_pressed():
	on_button_pressed(5)

func checkMagic():
	for magic in arrMagic:
		if magic == arrNodeClicked:
			return magic

func buttons_visible(val):
	$Button1.visible=val
	$Button2.visible=val
	$Button3.visible=val
	$Button4.visible=val
	$Button5.visible=val

func _on_label_ready():
	$RichTextLabel.text = start[pos]
	pos += 1
	
func _input(event):
	if event.is_action_pressed("skip_dialog"):
		if pos <= start.size() and is_start_dialog and can_click:
			if pos == start.size():
				pos += 1
			else :
				$RichTextLabel.text = start[pos]
				pos += 1
			
		if (pos > start.size() and can_click):
			pos = 0
			is_start_dialog = false
			buttons_visible(true)
		if (!is_start_dialog and can_click and pos < spells.size()):	
			print(current_combo.size())
			print(arrNodeClicked.size())
			if (current_combo.size() == arrNodeClicked.size()):
				arrNodeClicked.clear()
				arrLine.clear()
				lstNodeClicked = 0
				queue_redraw()
				current_combo = []
				current_spell = spells[pos]
				dialog = current_spell
				correct_combos = 0
				for n in current_spell:
					current_combo.append(int(n))
			$RichTextLabel.text = "Use the following spell: " + dialog
		if (!is_start_dialog and can_click and pos == spells.size()):
			$RichTextLabel.text = tutorialFinished
		if !can_click:
			if arrNodeClicked.size() == current_combo.size() - 1:
				for m in arrNodeClicked.size():
					if arrNodeClicked[m] == current_combo[m]:
						correct_combos += 1
				if (correct_combos == arrNodeClicked.size()):
					$RichTextLabel.text = correct[randi() % correct.size()]
					pos += 1
				else:
					$RichTextLabel.text = incorrect[randi() % incorrect.size()]
		


func _on_button_1_mouse_entered():
	can_click = false


func _on_button_2_mouse_entered():
	can_click = false


func _on_button_3_mouse_entered():
	can_click = false


func _on_button_4_mouse_entered():
	can_click = false


func _on_button_5_mouse_entered():
	can_click = false


func _on_button_1_mouse_exited():
	can_click = true


func _on_button_2_mouse_exited():
	can_click = true


func _on_button_3_mouse_exited():
	can_click = true


func _on_button_4_mouse_exited():
	can_click = true


func _on_button_5_mouse_exited():
	can_click = true
