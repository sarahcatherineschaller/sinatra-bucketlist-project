class BucketlistsController < ApplicationController 

	get '/bucketlist' do 
		if !logged_in?
			redirect '/login' 
		else 
			@bucketlist = Bucketlist.all 
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

	post '/bucketlist' 
  	    if params[:item] == ""
		  redirect '/bucketlist/new'
	    else 
		  @bucketlist_item = current_user.bucketlist.create(item: params[:item])
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



end