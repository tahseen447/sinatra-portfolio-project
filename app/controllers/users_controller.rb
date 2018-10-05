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
        @user = User.new(:username=>params[:username], :email=>params[:email], :password =>params[:password])
        if @user.save
        session[:user_id] = @user.id
        binding.pry
        redirect to '/grocery_list'
      end
      end
    end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    end
  end

  post "/login" do
		user = User.find_by(:username => params[:username])
    binding.pry
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
      redirect to '/grocery_list'
    else
      redirect to '/signup'
		end
	end

  get "/users/logout" do
    if logged_in?
      session.clear
    end
      redirect to '/'
  end

end
