class Zone
	def initialize(top_left, bottom_right)
		@top_left = top_left
		@bottom_right = bottom_right
	end
	
	def split
		[
			Zone.new({:x => @top_left[:x], :y => @top_left[:y]}, {:x => @bottom_right[:x]/2.0, :y => @bottom_right[:y]}),
			Zone.new({:x => @top_left[:x] + width / 2.0, :y => @top_left[:y]}, {:x => @bottom_right[:x], :y => @bottom_right[:y]}),
		]
	end
	
	def width
		(@bottom_right[:x] - @top_left[:x]).abs
	end
	
	def contains(coordinate)
		@top_left[:x] <= coordinate[:x] && 
		@top_left[:y] >= coordinate[:y] && 
		@bottom_right[:x] > coordinate[:x] && 
		@bottom_right[:y] < coordinate[:y]
	end
	
	def is_adjacent_to(other)
	end
end

class ContentAddressableNode
	attr_accessor :neighbors, :zone, :position

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
		split_zones = @zone.split
		node.zone = split_zones[0]
		self.zone = split_zones[1]
		node.choose_neighbors([@neighbors, self].flatten)
		self.choose_neighbors([@neighbors, node].flatten)
	end

	def choose_neighbors(potential_neighbors)
		potential_neighbors.select {|p| self.}
	end

	def is_neighbor_of(node)
		@zone.is_adjacent_to(node.zone)
	end

	def owns(coordinate)
		@zone.contains(coordinate)
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

