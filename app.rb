ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class Makersbnb < Sinatra::Base

 register Sinatra::Flash

  enable :sessions
  set :session_secret, 'super secret'

  # helpers do
  #   def current_user
  #     @current_user ||= User.get(session[:user_id])
  #   end
  # end

  get '/' do
    redirect 'listings'
  end

  get '/user/new' do
    erb :'signup'
  end

  post '/user/signing_up' do
    
  end

  get '/listings' do
    @listings = Listing.all
    erb :'listings'
  end

  get '/listings/new' do
    erb :'new_listing'
  end

  post '/listings' do
    listing = Listing.new(name: params[:name], description: params[:description], price: params[:price])
    listing.save
    redirect '/listings'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
