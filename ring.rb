class Ring
	def initialize(&hash)
		@hex_digits = 3
		@nodes = []
		@hash = hash
	end

	def index(i)
		i % @nodes.count
	end

	def add_node(i, node)
		raise "Node index has to exist between 0 and 1." if i < 0 || i > 1
		duplicate_index = @nodes.index {|n| n.index == i}
		raise "Node replacement not supported yet" if !duplicate_index.nil?
		node.index = i
		@nodes << node
		@nodes.sort! {|n1, n2| n1.index <=> n2.index}
		new_node_index = @nodes.index(node)
		downstream_node_index = index(new_node_index + 1)
		if (downstream_node_index < new_node_index)
			@nodes[downstream_node_index].redistribute_overflows_to(node)
		else
			@nodes[downstream_node_index].redistribute_normally_to(node)
		end
	end

	def set(key, value)
		nearest_node(key).set(key, value)
	end
	
	def nearest_node(key)
		bucket = @hash.call(key)
#		puts "Key=#{bucket}"
		nearest_node = @nodes.find {|n| n.index >= bucket}
		nearest_node = @nodes.min {|n1, n2| n1.index <=> n2.index} if nearest_node.nil?
		raise "No nodes found" if nearest_node.nil?
		nearest_node
	end
	
	def get(key)
		nearest_node(key).get(key)
	end
end

