class ContentAddressableNode
	attr_accessor :neighbors, :top_left, :bottom_right, :position

	def initialize
		@neighbors = []
	end
	
	def bootstrap_using(other)
		@position = {:x => rand, :y => rand}
		owning_node = other.route_to(@position)
		owning_node.accomodate(self)
	end
	
	def route_to(coordinate)
		return self if owns(coordinate)
		closest_neightbor = @neighbors.min {|n| distance(n.position, coordinate)}
		closest_neightbor.route_to(coordinate)
	end
	
	def accomodate(node)
	end

	def owns(coordinate)
		@top_left[:x] <= coordinate[:x] && 
		@top_left[:y] >= coordinate[:y] && 
		@bottom_right[:x] > coordinate[:x] && 
		@bottom_right[:y] < coordinate[:y]
	end

	def distance(p1, p2)
		(p1[:x] - p2[:x])**2 + (p1[:y] - p2[:y])**2
	end
end

class ContentSpace
	def initialize
		@nodes = []
	end
	
	def add(node)
		if (@nodes.empty?)
			node.top_left = {:x => 0, :y => 0}
			node.bottom_right = {:x => 1, :y => 1}
		end
		bootstrap_node = @nodes[rand(@nodes.count)]
		@nodes << node
		node.bootstrap_using(bootstrap_node)
	end
end

