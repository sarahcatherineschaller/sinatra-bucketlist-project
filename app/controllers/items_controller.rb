class ItemsController < ApplicationController 

	get '/bucketlist' do 
		if !logged_in? 
			redirect '/login' 
		else 
			@user = current_user 
			@bucketlist = BucketList.all
			erb :'/bucketlist/bucketlist'
		end 
	end 

	get '/bucketlist/new' do 
		if !logged_in?
			redirect '/login' 
		else 
			erb :'/bucketlist/create_item'
		end 
	end 

	post '/bucketlist' do 
		if params[:item] == "" 
			redirect to '/bucketlist/new'
		else 
			@bucketlist = BucketList.create(item: params[:item], notes: params[:notes])
			redirect "/bucketlist/#{@bucketlist.id}"
		end 
	end

	get '/bucketlist/:id' do 
		if !logged_in?
			redirect '/login'
		else 
			@bucketlist = BucketList.find_by(params[:id])
			erb :'/bucketlist/show_item'
		end 
	end

	get '/bucketlist/:id/edit' do 
		if !logged_in?
			redirect '/login' 
		else 
			@bucketlist = Bucketlist.find_by(params:id)
			erb :'/bucketlist/edit_item'
		end 
	end 

	patch '/bucketlist/:id' do 
		@bucketlist = Bucketlist.find_by(params[:id])
		@bucketlist.update(item: params[:item], notes: params[:notes])
		@bucketlist.save 
		redirect "/bucketlist/#{@bucketlist.id}/edit"
	end 

	delete '/bucketlist/:id/delete' do 
		if !logged_in?
			redirect '/login' 
		else 
			@bucketlist = BucketList.find_by_id(params[:id])
			if @bucketlist.user_id == session[:user_id]
				@bucketlist.delete 
				redirect '/bucketlist' 
			else 
				redirect '/bucketlist'
			end 
		end
	end







end