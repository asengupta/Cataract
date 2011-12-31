require './content_addressable_node'
require 'rubygems'
require 'test/unit'

class ContentSpaceTest < Test::Unit::TestCase
	def test_single_node_can
		space = ContentSpace.new
		node1 = ContentAddressableNode.new
		node2 = ContentAddressableNode.new
		space.add(node1)
		space.add(node2)
	end
end

