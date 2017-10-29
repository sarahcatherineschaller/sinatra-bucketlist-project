class BucketlistsController < ApplicationController 

	get '/bucketlist' do 
		if logged_in?
			@bucketlist = Bucketlist.all 
			erb :'/bucketlist/bucketlist'
		else
			redirect '/login'
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
		  redirect '/bucketlist/new'
	    else 
		  @bucketlist_item = Bucketlist.create(item: params[:item])
		  redirect "/bucketlist/#{@bucketlist_item.id}"
	    end 
	end

	get '/bucketlist/:id' do 
		if logged_in?
			@bucketlist_item = Bucketlist.find_by_id(params[:id])
			erb :'/bucketlist/show_item' 
		else 
			redirect '/login' 
		end 
	end

	get '/bucketlist/:id/edit' do 
		if !logged_in?
			redirect '/login'
		else 
			@bucketlist_item = Bucketlist.find_by_id(params[:id])
			erb :'/bucketlist/edit_item'
		end 
	end

	patch '/bucketlist/:id' do 
		if params[:item] == ""
			redirect to "/bucketlist/#{params[:id]}/edit"
		else 
			@bucketlist_item = Bucketlist.find_by_id(params[:id])
			@bucketlist_item.item = params[:item]
			@bucketlist_item.save 
			redirect "/bucketlist/#{@bucketlist_item.id}"
		end 
	end




end