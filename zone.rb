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
			Zone.new({:x => @top_left[:x], :y => (@top_left[:y] + @bottom_right[:y])/2.0}, {:x => @bottom_right[:x], :y => @bottom_right[:y]})
		]
	end
	
	def width
		(@bottom_right[:x] - @top_left[:x]).abs
	end
	
	def height
		(@bottom_right[:y] - @top_left[:y]).abs
	end

	def contains(coordinate)
		puts "Does #{self.inspect} contain #{coordinate.inspect}??"
		@top_left[:x] <= coordinate[:x] && @top_left[:y] >= coordinate[:y] && @bottom_right[:x] >= coordinate[:x] && @bottom_right[:y] <= coordinate[:y]
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
		  
		aligned_horizontally || aligned_vertically
	end
end

