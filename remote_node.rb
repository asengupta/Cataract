require './hash_functions'

class RemoteNode
	attr_accessor :hash, :index, :uri
	def initialize(&hash)
		@stripes = {}
		@hash = hash
		puts "Created with id=#{self.object_id}"
	end

	def flush
		@stripes = {}
	end
	
	def set(key, value)
		puts "Putting #{@hash.call(key)} in #{index}"
		@stripes[key] = value
	end
	
	def get(key)
		@stripes[key]
	end

	def remove(key)
		@stripes.delete(key)
	end

	def redistribute_overflows_to(upstream_node)
		redistribute_to(upstream_node) {|key_position| key_position <= upstream_node.index && key_position > self.index}
	end

	def redistribute_normally_to(upstream_node)
		redistribute_to(upstream_node) {|key_position| key_position <= upstream_node.index}
	end

	def redistribute_to(upstream_node)
		keys_to_migrate = []
		@stripes.each_key do |k|
#			puts "Hashed position of #{k} = #{hash.call(k)}, my position is #{index}, upstream is #{upstream_node.index}"
			keys_to_migrate << k if yield(@hash.call(k))
		end
		keys_to_migrate.each do |k|
			puts "Redistributing #{k} to #{upstream_node.index}"
			upstream_node.set(k, @stripes[k])
			self.remove(k)
		end
	end
end

