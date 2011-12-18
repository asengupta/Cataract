class Node
	def initialize
		@stripes = {}
	end

	attr_accessor :hash, :index
	def set(key, value)
		@stripes[key] = value
	end
	
	def get(key)
		@stripes[key]
	end

	def remove(key)
		@stripes.delete(key)
	end

	def redistribute_to(upstream_node)
		keys_to_migrate = []
		@stripes.each_key do |k|
#			puts "Hashed position of #{k} = #{hash.call(k)}, my position is #{index}, upstream is #{upstream_node.index}"
			keys_to_migrate << k if hash.call(k) <= upstream_node.index
		end
		keys_to_migrate.each do |k|
			puts "Redistributing #{k} to #{upstream_node.index}"
			upstream_node.set(k, @stripes[k])
			self.remove(k)
		end
	end
end

