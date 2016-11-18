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
  @showEnv=ENV["RABBITMQ_BIGWIG_URL"]
  erb :index
end
get '/start' do
  Thread.new{require_relative './notification_server.rb'}
end
