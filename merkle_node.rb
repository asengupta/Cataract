require 'digest/tiger'

include Digest

class MerkleNode
	attr_accessor :left, :right
end

Tiger.hexdigest("blah")

