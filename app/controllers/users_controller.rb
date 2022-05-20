class UsersController < ApplicationController 

  get '/signup' do
    if logged_in?
      redirect '/tasks'
    else
    erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
    redirect '/tasks'
    end
  end
  
  get '/login' do
    if logged_in?
      redirect '/tasks'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tasks'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:id/delete' do 
    @user = User.find_by_id(session[:user_id])
    if @user
      erb :'users/delete'
    else
      redirect to "/login"
    end
  end

  get "/users/:id/edit" do 
    @user = User.find_by_id(session[:user_id])
    if @user 
      erb :'users/edit'
    else
      redirect to "/login"
    end
  end

  patch "/users/:id" do 
    @user = User.find_by_id(params[:id])
    @user.update(username: params[:username])
    redirect '/tasks'
  end

  patch "/users/:id/deletion" do 
    @user = User.find_by_id(params[:id])
    @user.destroy
    session.clear
    redirect to '/login'
  end
end