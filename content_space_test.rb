require './content_space'
require 'rubygems'
require 'test/unit'

class ContentSpaceTest < Test::Unit::TestCase
	def test_single_node_can
		space = ContentSpace.new
		nodes = []
		n1 = ContentAddressableNode.new
		n2 = ContentAddressableNode.new
		n3 = ContentAddressableNode.new
		n4 = ContentAddressableNode.new
		begin
			space.add(n1)
			space.add(n2)
			space.add(n3)
			space.add(n4)
		rescue
			puts "Final end report"
			puts "="*30
			puts n1.inspect
			puts n2.inspect
			puts n3.inspect
			puts n4.inspect
			puts "="*30
		end
#		puts "Final end report"
#		puts "="*30
#		puts n1.inspect
#		puts n2.inspect
#		puts n3.inspect
#		puts n4.inspect
#		puts "="*30
#		30.times { nodes << ContentAddressableNode.new}
#		nodes.each {|n| space.add(n)}
	end
end

