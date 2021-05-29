extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var graph = {}

func get_neighbours(source_cell):
	var neighbours = []
	for cell in get_used_cells():
		if cell == source_cell:
			continue
		
		if abs(cell[0] - source_cell[0]) <= 1 and abs(cell[1] - source_cell[1]) <= 1:
			if !neighbours.has(cell):
				neighbours.append(cell)
			
	
	return neighbours
	
	

func construct_graph():
	for cell in get_used_cells():
		graph[cell] = get_neighbours(cell)

# Called when the node enters the scene tree for the first time.
func _ready():
	construct_graph()
	
	
	
		
		

var active = false
var visited = []
var start_node = 45

func go(visited, graph, node):
	if !visited.has(node) and active:
		
		set_cell(node[0], node[1], 0)

		visited.append(node)
		
		var timer = Timer.new()
		timer.set_wait_time(0.3)
		timer.set_one_shot(true)
		self.add_child(timer)
		timer.start()
		
		yield(timer, "timeout")
		
		for neigbour in graph[node]:
			go(visited, graph, neigbour)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_StartButton_pressed():
	active = true
	go(visited, graph, get_used_cells()[start_node])


func _on_StopButton_pressed():
	active = false
