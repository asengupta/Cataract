class Zone
	attr_accessor :top_left, :bottom_right
	def initialize(top_left, bottom_right)
		@top_left = top_left
		@bottom_right = bottom_right
	end
	
	def center
		{:x => (@top_left[:x] + @bottom_right[:x])/2.0, :y => (@top_left[:y] + @bottom_right[:y])/2.0}
	end

	def split
		return [
			Zone.new({:x => @top_left[:x], :y => @top_left[:y]}, {:x => (@top_left[:x] + @bottom_right[:x]) / 2.0, :y => @bottom_right[:y]}),
			Zone.new({:x => (@top_left[:x] + @bottom_right[:x]) / 2.0, :y => @top_left[:y]}, {:x => @bottom_right[:x], :y => @bottom_right[:y]})
		] if rand > 0.5
		[
			Zone.new({:x => @top_left[:x], :y => @top_left[:y]}, {:x => @bottom_right[:x], :y => (@top_left[:y] + @bottom_right[:y])/2.0}),
			Zone.new({:x => (@top_left[:x] + @bottom_right[:x]) / 2.0, :y => @top_left[:y]}, {:x => @bottom_right[:x], :y => @bottom_right[:y]})
		]
	end
	
	def width
		(@bottom_right[:x] - @top_left[:x]).abs
	end
	
	def height
		(@bottom_right[:y] - @top_left[:y]).abs
	end

	def contains(coordinate)
		@top_left[:x] <= coordinate[:x] && 
		@top_left[:y] >= coordinate[:y] && 
		@bottom_right[:x] > coordinate[:x] && 
		@bottom_right[:y] < coordinate[:y]
	end
	
	def is_adjacent_to(other)
		aligned_horizontally =
		 ((other.top_left[:y] == self.bottom_right[:y] || other.bottom_right[:y] == self.top_left[:y]) && 
		!(other.top_left[:x] < self.top_left[:x] && other.bottom_right[:x] <= self.top_left[:x] ||
		  other.top_left[:x] >= self.bottom_right[:x] && other.bottom_right[:x] > self.bottom_right[:x]))
		
		aligned_vertically =
		((other.top_left[:x] == self.bottom_right[:x] || other.bottom_right[:x] == self.top_left[:x]) && 
		!(other.top_left[:y] > self.top_left[:y] && other.bottom_right[:y] >= self.top_left[:y] ||
		  other.top_left[:y] <= self.bottom_right[:y] && other.bottom_right[:y] < self.bottom_right[:y]))
		  
#		puts "Aligned horizontally = #{aligned_horizontally}"
#		puts "Aligned vertically = #{aligned_vertically}"

		aligned_horizontally || aligned_vertically
	end
end

class ContentAddressableNode
	attr_accessor :neighbors, :zone, :position

	def initialize
		@neighbors = []
	end
	
	def bootstrap_using(other)
		@position = {:x => rand, :y => rand}
#		puts "New chosen position is #{@position.inspect}"
		owning_node = other.route_to(@position)
		owning_node.accomodate(self)
	end
	
	def route_to(coordinate)
		return self if owns(coordinate)
		closest_neightbor = @neighbors.min {|n| distance(n.position, coordinate)}
		closest_neightbor = self if closest_neightbor.nil?
		closest_neightbor.route_to(coordinate)
	end
	
	def accomodate(node)
		split_zones = @zone.split
		node.zone = split_zones[0]
		self.zone = split_zones[1]
		node.position = node.zone.center
		self.position = self.zone.center
		node.choose_neighbors([@neighbors, self].flatten)
		self.choose_neighbors([@neighbors, node].flatten)
	end

	def choose_neighbors(potential_neighbors)
		@neighbors = potential_neighbors.select {|p| self.is_neighbor_of(p)}
	end

	def is_neighbor_of(node)
		@zone.is_adjacent_to(node.zone)
	end

	def owns(coordinate)
		puts "Containes = #{@zone.contains(coordinate)}"
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
			node.zone = Zone.new({:x => 0, :y => 1}, {:x => 1, :y => 0})
			node.position = {:x => 0.5, :y => 0.5}
			@nodes << node
 			return
		end
		bootstrap_node = @nodes[rand(@nodes.count)]
		@nodes << node
		node.bootstrap_using(bootstrap_node)
	end
end

