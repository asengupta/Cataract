require './content_addressable_node'

z1 = Zone.new({:x => 0.2, :y => 0.4}, {:x => 0.4, :y => 0.2})
z2 = Zone.new({:x => 0.1, :y => 0.15}, {:x => 0.15, :y => 0.1})
z3 = Zone.new({:x => 0.1, :y => 0.2}, {:x => 0.2, :y => 0.1})

puts z1.is_adjacent_to(z2)
puts z1.is_adjacent_to(z3)

