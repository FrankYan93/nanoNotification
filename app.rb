require 'sinatra'
require 'sinatra/activerecord'
require 'bunny'
require 'thread'
require 'json'
require 'zlib'
require 'amqp'
require 'eventmachine'

Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/services/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/api/*.rb'].each { |file| require file }

set :port, 9494
get '/' do
  erb :index
end
get '/start' do
  require_relative './notification_server.rb'
end
  # connection = AMQP.connect(:host => '127.0.0.1', :port => 5672, :vhost => 'a')
  # puts "Connecting to AMQP broker. Running #{AMQP::VERSION} version of the gem..."
  #
  # channel  = AMQP::Channel.new(connection)
  # channel.queue("amqpgem.examples.hello_world", :auto_delete => true, :nowait => true) do |queue|
  #   exchange = channel.default_exchange
  #
  #   queue.subscribe do |payload|
  #     puts "Received a message: #{payload}. Disconnecting..."
  #
  #     EventMachine::Timer.new(60) do
  #       connection.close {
  #         EventMachine.stop { exit }
  #       }
  #     end
  #   end
  #
  #   exchange.publish "Hello, world!", :routing_key => queue.name
  # end
