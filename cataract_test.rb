require 'digest/sha2'
require './ring'
require './in_memory_node'

include Digest

def sha_hash(key)
	Integer("0x" + (SHA2.new << key).to_s[-3..-1])/8192.0
end

r = Ring.new(200) {|k| sha_hash(k)}

index = 0
while (index <= 1)
	puts index
	r.add_node(index, InMemoryNode.new)
	index += 0.2
end

r.set("XBlah.txtX", "haha")
r.set("XXaBlah.txtXX", "haha")
r.set("XXXBlah.txtXXX", "haha")

r.add_node(0.45, InMemoryNode.new)

puts r.get("XXaBlah.txtXX")

