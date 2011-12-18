require './ring'
require './remote_node'
require './hash_functions'

r = Ring.new {|k| sha_hash(k)}

index = 0

while (index <= 1)
	r.add_node(index, RemoteNode.new {|k| sha_hash(k)})
	index += 0.2
end

r.set("1XBlah.txtX", "haha")
r.set("2XXaBlah.txtXX", "haha")
r.set("3XXXBlah.txtXXX", "haha")
r.set("3XXXBlah.txtXXXA", "haha")

r.add_node(0.387, RemoteNode.new {|k| sha_hash(k)})

puts r.get("2XXaBlah.txtXX")

