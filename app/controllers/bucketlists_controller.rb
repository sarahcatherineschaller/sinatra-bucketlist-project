
class BucketlistsController < ApplicationController 

	get '/bucketlist' do 
		if logged_in?
			@bucketlist = current_user.bucketlists
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
	      user = current_user
		  @bucketlist_item = Bucketlist.create(item: params[:item], user_id: user.id)
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

	delete '/bucketlist/:id/delete' do 
		if logged_in? 
			@bucketlist_item = Bucketlist.find_by_id(params[:id])
			if @bucketlist_item.user_id == session[:user_id]
				@bucketlist_item.delete 
				redirect '/bucketlist'
			else 
			    redirect '/bucketlist'
			end 
		else 
			redirect '/login'
		end 
	end




end