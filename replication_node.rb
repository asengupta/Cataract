require 'amqp'

class ReplicationNode
	def initialize(host, port)
		@host = host
		@port = port
	end

	def run
		EventMachine.run do
#			connection = AMQP.connect(:host => '127.0.0.1', :port => 5672)
			connection = AMQP.connect(:host => @host, :port => @port)
		  	puts "Connected to AMQP broker. Running #{AMQP::VERSION} version of the gem..."
		  	channel = AMQP::Channel.new(connection)
		  	exchange = channel.direct('replication_exchange', :auto_delete => true)
			queue = channel.queue('replication_queue', :auto_delete => false, :passive => false)
		  	queue.bind(exchange, :routing_key => 'replicate')
			queue.subscribe do |payload|
				puts "Received a message: #{payload}. Good..."
			end
		end
	end
end

