require './node'

class Ring
	def initialize(max_nodes, &hash)
		@hex_digits = 3
#		@max_nodes = 2**(@hex_digits*4 + 1) - 1
		@max_nodes = max_nodes
		@nodes = Array.new(@max_nodes)
		@hash = hash
	end

	def index(i)
		i % @max_nodes
	end

	def add_node(i, node)
		raise "Node replacement not supported yet" if !@nodes[index(i)].nil?
		node.index = index(i)/@max_nodes.to_f
		node.hash = @hash
		@nodes[index(i)] = node
		current_index = index(i + 1)
		while(@nodes[current_index].nil?)
			current_index = index(current_index + 1)
		end
		@nodes[current_index].redistribute_to(node)
	end

	def set(key, value)
		nearest_node(key).set(key, value)
	end
	
	def nearest_node(key)
		bucket = (@hash.call(key) * @max_nodes).to_i
		current_index = bucket
		while(@nodes[current_index].nil?)
			current_index = index(current_index + 1)
			raise "No nodes found" if current_index == bucket
		end
		@nodes[current_index]
	end
	
	def get(key)
		nearest_node(key).get(key)
	end
end

