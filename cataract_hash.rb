require './ring_setup'

class CataractHash
	def initialize(ring)
		@ring = ring
	end
	
	def set(key, value)
		@ring.set(key, value)
	end

	def get(key)
		@ring.get(key)
	end
end

