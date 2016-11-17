require 'sinatra'
require 'sinatra/activerecord'
require 'bunny'
require 'thread'
require 'json'
require 'zlib'

Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| require file }

set :port, 9494
get '/' do
  erb :index
end

#Dir[File.dirname(__FILE__) + '/services/*.rb'].each { |file| require file }
