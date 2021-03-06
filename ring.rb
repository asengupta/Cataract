class Ring
	def initialize(replicas = 0, &hash)
		@hex_digits = 3
		@nodes = []
		@hash = hash
		@replicas = replicas
	end

	def index(i)
		i % @nodes.count
	end

	def remove_node(i)
		raise "Node index has to exist between 0 and 1." if i < 0 || i > 1
		@nodes.delete_if {|n| n.index == i}
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
		nearest = nearest_node(key)
		nearest.set(key, value)
		replicate(nearest, key, value)
	end

	def replicate(nearest, key, value)
		nearest_index = @nodes.index(nearest)
		i = 1
		while (i <= @replicas)
			replica_node = @nodes[index(nearest_index + i)]
			replica_node.set(key, value)
			puts "Replicating into #{replica_node.index}"
			i += 1
		end
	end
	
	def nearest_node(key)
		bucket = @hash.call(key)
		nearest_node = @nodes.find {|n| n.index >= bucket}
		nearest_node = @nodes.min {|n1, n2| n1.index <=> n2.index} if nearest_node.nil?
		raise "No nodes found" if nearest_node.nil?
		nearest_node
	end
	
	def get(key)
		nearest_node(key).get(key)
	end
end

