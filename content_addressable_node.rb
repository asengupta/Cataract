require './zone'
class ContentAddressableNode
	attr_accessor :neighbors, :zone, :position

	def to_s
		neighbor_list = @neighbors.inject("Neighbors") {|all, n| all + n.zone.inspect}
		@zone.inspect + neighbor_list
	end
	
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
#		puts "Routing #{coordinate.inspect} through #{self.zone.inspect}"
#		puts "Num neighbors = #{@neighbors.count}"
		return self if owns(coordinate)
		closest_neighbor = @neighbors.min_by {|n| distance(n.position, coordinate)}
#		@neighbors.each {|n| p "#{distance(n.position, coordinate)} is between #{coordinate} and #{n}"}
#		p "Choosing #{closest_neighbor}"
		closest_neighbor.route_to(coordinate)
	end
	
	def accomodate(node)
		split_zones = @zone.split
		node.zone = split_zones[0]
		self.zone = split_zones[1]
		node.position = node.zone.center
		self.position = self.zone.center
#		node.neighbors.each do |n|
#			n.adjust(self)
#			n.adjust(node)
#		end
		@neighbors.each do |n|
			n.adjust(self)
			n.adjust(node)
		end
#		puts "Choosing from #{@neighbors.count} neighbors"
		node.choose_neighbors([@neighbors, self].flatten)
#		puts "Now choosing from #{@neighbors.count} neighbors"
		self.choose_neighbors([@neighbors, node].flatten)
	end

	def adjust(neighbor)
		@neighbors.delete(neighbor) if !neighbor.is_neighbor_of(self)
		@neighbors << neighbor if neighbor.is_neighbor_of(self) && @neighbors.index(neighbor).nil?
	end
	
	def choose_neighbors(potential_neighbors)
		@neighbors = potential_neighbors.select {|p| p.is_neighbor_of(self)}
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

