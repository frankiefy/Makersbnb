ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'helpers'

require_relative 'data_mapper_setup'

require 'pry' if ENV["RACK_ENV"] == "development"

class Makersbnb < Sinatra::Base

 register Sinatra::Flash
 use Rack::MethodOverride

  enable :sessions
  set :session_secret, 'super secret'

  helpers ApplicationHelper

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
      flash.now[:notice] = @user.errors.map { | messages| "Some problems arised: #{message}" }
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
      flash.now[:notice] = 'The email or password is incorrect'
      erb :'user/login'
    end
  end

  get '/space/new' do
    check_user_existing
    erb :'space/new'
  end

  post '/space/create' do
    check_user_existing
    space = Space.new(user: current_user,
                      name: params[:name],
                      description: params[:description],
                      price: params[:price],
                      start_date: params[:start_date],
                      end_date: params[:end_date])

    if space.save
      redirect '/space/list'
    else
      flash.now[:notice] = space.errors.map { | messages| "Some problems arised: #{messages}" }
      erb :'space/new'
    end

  end

  get '/space/list' do
    @spaces = Space.all
    erb :'space/list'
  end

  delete '/user/logout' do
    flash.keep[:notice] = "Goodbye #{current_user.email}!"
    session[:email] = nil
    redirect to '/user/login'
  end

  post '/space/view' do
    @space = Space.get(params[:space_id])
    erb :'space/view'
  end

  post '/request/new' do
    new_request = Request.new(date: params[:request_date], space: Space.get(params[:space_id]))

    if new_request.save
      redirect '/request/view'
    else
      flash.now[:notice] = new_request.errors.map { | messages| "Some problems arised: #{messages}" }
      erb :'space/view'
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
