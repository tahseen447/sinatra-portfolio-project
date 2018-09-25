class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/grocery_list'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to '/signup'
      else
        @user = User.create(:username=>params[:username], :email=>params[:email], :password =>[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to '/grocery_list'
      end
    end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    end
  end

  post "/login" do
		user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
      redirect to '/grocery_list'
    else
      redirect to '/signup'
		end
	end

  get "/users/logout" do
    binding.pry
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect to '/'
    end
  end

end
