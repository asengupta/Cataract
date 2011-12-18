require 'drb'

class RemoteNodeProxy
	def self.node(port)
		DRbObject.new nil, "druby://:#{port}"
	end
end

