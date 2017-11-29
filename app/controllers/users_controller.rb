class UsersController < ApplicationController 

	get '/signup' do 
		if logged_in?
			redirect '/bucketlist'
		else 
			erb :'users/signup'
		end 
	end

	post '/signup' do 
		@errors = {}
		if params[:username] == "" 
			@errors[:username] = "Username can't be blank!"
		elsif User.find_by(username: params[:username])
			@errors[:username] = "Username has already been taken!"
		end

		if params[:email] == ""
			@errors[:email] = "Email can't be blank"
		end 

		if params[:password] == ""
			@errors[:password] = "Password can't be blank"
		end

		if @errors.empty?
			@user = User.create(username: params[:username], email: params[:email], password: params[:password])
			@user.save
			session[:user_id] = @user.id 
			redirect '/bucketlist'
		else 
			erb :'users/signup'
		end 
	end

	get '/login' do 
		if logged_in?
			redirect '/bucketlist'
		else 
			erb :'users/login'
		end 
	end

	post '/login' do 
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect '/bucketlist'
		else
			redirect '/signup'
		end 
	end

	get '/logout' do 
		if logged_in? 
			session.clear 
			redirect '/login'
		else 
			redirect '/'
		end 
	end

end