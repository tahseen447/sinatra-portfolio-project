class GrocerListController < ApplicationController
  get '/grocery_list' do
    if logged_in?
      @lists = current_user.grocery_lists
      erb :'grocery_list/list'
    else
      redirect to '/login'
    end
  end

  get '/grocery_list/new' do
    if logged_in?
      erb :'grocery_list/new'
    else
      redirect to '/login'
    end
  end

  post '/grocery_list' do
    if logged_in?
      if params[:content] == ""
        redirect to "/grocery_list/new"
      else
        @grocery_list = current_user.grocery_lists.build(store_name: params[:store_name], item_list: params[:content])
        if @grocery_list.save
          redirect to "/grocery_list/#{@grocery_list.id}"
        else
          redirect to "/grocery_list/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/grocery_list/:id' do
    if logged_in?
      @grocery_list = GroceryList.find_by_id(params[:id])
      erb :'grocery_list/show_grocery_list'
    else
      redirect to '/login'
    end
  end

  get '/grocery_list/:id/edit' do
    if logged_in?
      @grocery_list = GroceryList.find_by_id(params[:id])
      if @grocery_list && @grocery_list.user == current_user
        erb :'grocery_list/edit_grocery_list'
      else
        redirect to '/grocery_list'
      end
    else
      redirect to '/login'
    end
  end

  patch '/grocery_list/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/grocery_list/#{params[:id]}/edit"
      else
        @grocery_list = GroceryList.find_by_id(params[:id])
        if @grocery_list && @grocery_list.user == current_user
          if @grocery_list.update(store_name: params[:store_name], item_list: params[:content])
            redirect to "/grocery_list/#{@grocery_list.id}"
          else
            redirect to "/grocery_list/#{@grocery_list.id}/edit"
          end
        else
          redirect to '/grocery_list'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/grocery_list/:id/delete' do
          binding.pry
    if logged_in?
      @grocery_list = GroceryList.find_by_id(params[:id])
      if @grocery_list && @grocery_list.user == current_user
        @grocery_list.delete
      end
      redirect to '/grocery_list'
    else
      redirect to '/login'
    end
  end
end
