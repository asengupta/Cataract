require 'drb'
require './remote_node'

raise "No port specified for Cataract remote node. Usage: ruby remote_node.rb <port>" if ARGV.first.nil?
remote_node = RemoteNode.new {|k| sha_hash(k)}
DRb.start_service "druby://:#{ARGV.first}", remote_node
remote_node.uri = DRb.uri
puts "Server running at #{DRb.uri}"

trap("INT") { DRb.stop_service }
DRb.thread.join

