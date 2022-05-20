class TasksController < ApplicationController 

  get '/tasks' do
    @page = params['page'].nil? ? 0 : params['page']
    redirect_if_not_logged_in
    @user = current_user
    @lists = @user.lists.offset(@page).limit(PER_PAGE)
    @list_count = @user.lists.count
    erb :'tasks/show'
  end

  get '/tasks/new' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = List.all
    erb :'/tasks/new'
  end

  post '/tasks/new' do
    Task.create(:name => params[:name], :list_id => params[:list_id])
    redirect '/tasks'
  end

  get '/tasks/new/:id' do
    redirect_if_not_logged_in
    @list = List.find_by_id(params[:id])
    erb :'/tasks/new_on_list'
  end

  post '/tasks/new/:id' do
    @list = List.find_by_id(params[:id])
    Task.create(:name => params[:name], :list_id => params[:id])
    redirect '/tasks'
  end
end