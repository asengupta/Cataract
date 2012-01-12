require './zone'
require './content_addressable_node'

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

