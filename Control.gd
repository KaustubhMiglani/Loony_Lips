extends Control

var player_words=[]

var story="Once upon a time there was a kid named %s who lived in %s.Ever since %s,he wanted to go out.The day was %s."

var prompts=["name","place","year","adjective"]

var template=[{	"prompts":["name","place","year","adjective"],
	"story":"Once upon a time there was a kid named %s who lived in %s.Ever since %s,he wanted to go out.The day was %s." },
	{"prompts":["name","place","year","adjective"],
	"story":"Once upon a time somebody named %s wanted to go to %s.Ever since %s,he wanted to do so.The day was %s." }
	]
func _ready():
	pick_current_story()
	get_node("Label").text="Hi ,Welcome to loony lips."+" May I have a noun please? "
	get_node("PlayerText").grab_focus()
	
func pick_current_story():
	randomize()
	var index=(randi()%(template.size()))
	story=template[index]["story"]
	prompts=template[index]["prompts"]
	
func _on_PlayerText_text_entered(new_text):
	add_to_words()
	what_to_do()


func _on_TextureButton_pressed():
	if(is_story_done()):
		get_tree().reload_current_scene()
	else:
		add_to_words()
		what_to_do()

func add_to_words():
	var current_text=get_node("PlayerText").text
	player_words.append(current_text)
	get_node("PlayerText").clear()

func is_story_done():
	return (player_words.size()==prompts.size())
	
	
func what_to_do():
	
	if(is_story_done()):
		tell_story()
	else:
		prompt_player()

func tell_story():
	get_node("Label").text=story%player_words
	get_node("Label").text+=("(Press the button for playing again)")
	get_node("PlayerText").queue_free()

func prompt_player():
	get_node("Label").text="May I have a " + prompts[player_words.size()] +" please?"









