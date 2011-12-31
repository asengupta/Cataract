require './content_addressable_node'
require 'rubygems'
require 'test/unit'

class ZoneTest < Test::Unit::TestCase
	def test_bottom_zone_adjacency
		z1 = Zone.new({:x => 0.2, :y => 0.4}, {:x => 0.4, :y => 0.2})
		z2 = Zone.new({:x => 0.1, :y => 0.15}, {:x => 0.15, :y => 0.1})
		z3 = Zone.new({:x => 0.1, :y => 0.2}, {:x => 0.2, :y => 0.1})
		z4 = Zone.new({:x => 0.1, :y => 0.2}, {:x => 0.3, :y => 0.1})
		z5 = Zone.new({:x => 0.3, :y => 0.2}, {:x => 0.8, :y => 0.1})
		z6 = Zone.new({:x => 0.4, :y => 0.2}, {:x => 0.8, :y => 0.1})
		z7 = Zone.new({:x => 0.45, :y => 0.2}, {:x => 0.8, :y => 0.1})
		z8 = Zone.new({:x => 0.1, :y => 0.2}, {:x => 0.8, :y => 0.1})

		assert_equal(false, z1.is_adjacent_to(z2))
		assert_equal(false, z1.is_adjacent_to(z3))
		assert_equal(true, z1.is_adjacent_to(z4))
		assert_equal(true, z1.is_adjacent_to(z5))
		assert_equal(false, z1.is_adjacent_to(z6))
		assert_equal(false, z1.is_adjacent_to(z7))
		assert_equal(true, z1.is_adjacent_to(z8))
	end

	def test_top_zone_adjacency
		z1 = Zone.new({:x => 0.2, :y => 0.4}, {:x => 0.4, :y => 0.2})
		z2 = Zone.new({:x => 0.1, :y => 0.15}, {:x => 0.15, :y => 0.1})
		z3 = Zone.new({:x => 0.1, :y => 0.8}, {:x => 0.2, :y => 0.4})
		z4 = Zone.new({:x => 0.1, :y => 0.8}, {:x => 0.3, :y => 0.4})
		z5 = Zone.new({:x => 0.3, :y => 0.8}, {:x => 0.8, :y => 0.4})
		z6 = Zone.new({:x => 0.4, :y => 0.8}, {:x => 0.8, :y => 0.4})
		z7 = Zone.new({:x => 0.45, :y => 0.8}, {:x => 0.8, :y => 0.4})
		z8 = Zone.new({:x => 0.1, :y => 0.8}, {:x => 0.8, :y => 0.4})

		assert_equal(false, z1.is_adjacent_to(z2))
		assert_equal(false, z1.is_adjacent_to(z3))
		assert_equal(true, z1.is_adjacent_to(z4))
		assert_equal(true, z1.is_adjacent_to(z5))
		assert_equal(false, z1.is_adjacent_to(z6))
		assert_equal(false, z1.is_adjacent_to(z7))
		assert_equal(true, z1.is_adjacent_to(z8))
	end

	def test_left_zone_adjacency
		z1 = Zone.new({:x => 0.2, :y => 0.4}, {:x => 0.4, :y => 0.2})
		z2 = Zone.new({:x => 0.1, :y => 0.15}, {:x => 0.15, :y => 0.1})
		z3 = Zone.new({:x => 0.1, :y => 0.2}, {:x => 0.2, :y => 0.1})
		z4 = Zone.new({:x => 0.1, :y => 0.3}, {:x => 0.2, :y => 0.1})
		z5 = Zone.new({:x => 0.1, :y => 0.6}, {:x => 0.2, :y => 0.3})
		z6 = Zone.new({:x => 0.1, :y => 0.6}, {:x => 0.2, :y => 0.1})

		assert_equal(false, z1.is_adjacent_to(z2))
		assert_equal(false, z1.is_adjacent_to(z3))
		assert_equal(true, z1.is_adjacent_to(z4))
		assert_equal(true, z1.is_adjacent_to(z5))
		assert_equal(true, z1.is_adjacent_to(z6))
	end

	def test_right_zone_adjacency
		z1 = Zone.new({:x => 0.2, :y => 0.4}, {:x => 0.4, :y => 0.2})
		z2 = Zone.new({:x => 0.4, :y => 0.3}, {:x => 0.8, :y => 0.1})
		z3 = Zone.new({:x => 0.4, :y => 0.6}, {:x => 0.8, :y => 0.3})
		z4 = Zone.new({:x => 0.4, :y => 0.6}, {:x => 0.8, :y => 0.1})

		assert_equal(true, z1.is_adjacent_to(z2))
		assert_equal(true, z1.is_adjacent_to(z3))
		assert_equal(true, z1.is_adjacent_to(z4))
	end
end

