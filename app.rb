ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'
require 'pry' if ENV["RACK_ENV"] == "development"

class Makersbnb < Sinatra::Base

 register Sinatra::Flash

  enable :sessions
  set :session_secret, 'super secret'

  helpers do
    def current_user
      @current_user ||= User.get(session[:email])
    end
  end

  get '/' do
    redirect 'spaces'
  end

  get '/user/new' do
     @user = User.new
    erb :'user/new'
  end

  post '/user/signing_up' do
    @user = User.new(email: params[:email], password: params[:password],
      password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/user/login')
    else
      flash.now[:notice] = @user.errors.map do | messages|
        # binding.pry
          "Problems with #{property}: #{message}"
      end
      erb :'user/new'
    end
  end

  get '/user/login' do
    erb :'user/login'
  end

  post '/user/logging_in' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:email] = params[:email]
      redirect '/spaces'
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'user/login'
    end
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'space/spaces'
  end

  get '/space/new' do
    erb :'space/new'
  end

  post '/spaces' do
    space = Space.new(name: params[:name], description: params[:description], price: params[:price])
    space.save
    redirect '/spaces'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
