require 'sinatra'
require 'sinatra/activerecord'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/config/environments.rb'].each { |file| require file }

#set :port, 9494
get '/' do
  erb :index
end

post '/submit' do
	@model = Model.new(name: params[:model])
	if @model.save
		redirect '/models'
	else
		"Sorry, there was an error!"
	end
end

get '/models' do
	@models = Model.all
	erb :models
end
