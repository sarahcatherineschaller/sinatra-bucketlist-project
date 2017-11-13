class UsersController < ApplicationController 

	get '/signup' do 
		if logged_in?
			redirect '/bucketlist'
		else 
			erb :'users/signup'
		end 
	end

	post '/signup' do 
		if !User.find_by(username: params[:username]).nil? 
			redirect '/signup'
		elsif
			params[:username] == "" || params[:email] == "" || params[:password] == ""
			redirect '/signup'
		else 
			@user = User.create(username: params[:username], email: params[:email], password: params[:password])
			@user.save
			session[:user_id] = @user.id 
			redirect '/bucketlist'
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