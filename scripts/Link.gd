extends LinkButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var links:Array = ['linktr.ee/visaocatolica',]#'visaocatolica.com.br', 'caritasinveritate.teo.br']

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, '_on_Link_pressed')
	$LinkTimer.connect("timeout", self, "_on_Timer_timeout")
	
func _on_Timer_timeout():
	var proximo_link:int = links.find(text)+1
	if proximo_link >= len(links):
		text = links[0]
	else:
		text = links[proximo_link]

func _on_Link_pressed():
	OS.shell_open('https://%s/' % [text])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
