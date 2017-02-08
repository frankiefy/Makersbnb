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
      @current_user ||= User.first(email: session[:email])
    end

    def check_user_existing
      redirect '/' unless current_user
    end
  end

  get '/' do
    redirect '/user/login'
  end

  get '/user/new' do
     @user = User.new
    erb :'user/new'
  end

  post '/user/signing_up' do
    @user = User.new(email: params[:email], password: params[:password],
      password_confirmation: params[:password_confirmation])
    if @user.save
      redirect to('/user/login')
    else
      flash.now[:notice] = @user.errors.map do | messages|
          "Some problems arised: #{message}"
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
      redirect '/space/list'
    else
      flash.now[:notice] = ['The email or password is incorrect']
      erb :'user/login'
    end
  end

  get '/space/new' do
    # TODO if current user doesn't exist send to login page
    erb :'space/new'
  end

  post '/space/create' do
    check_user_existing
    # TODO get a user somehow
    space = Space.new(name: params[:name], description: params[:description], price: params[:price]) # TODO add all Space attributes
    space.save # TODO  Needs a conditional guard
    redirect '/space/list'
  end

  get '/space/list' do
    @spaces = Space.all
    erb :'space/list'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
