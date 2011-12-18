require './remote_node_proxy'
require './ring'
require './hash_functions'

class RingSetup
	def ring(node_map)
		r = Ring.new {|k| sha_hash(k)}
		node_map.each_pair do |position, port|
			r.add_node(position, RemoteNodeProxy.node(port))
		end
		r
	end
end

