class ItemsController < ApplicationController 

	get '/bucketlist' do 
		if !logged_in? 
			redirect '/login' 
		else 
			@user = current_user 
			@bucketlist = BucketList.all
			erb :'/items/bucketlist'
		end 
	end 

	get '/bucketlist/new' do 
		if !logged_in?
			redirect '/login' 
		else 
			erb :'/items/create_item'
		end 
	end 

	post '/bucketlist' do 
		if params[:item] == "" 
			redirect to '/bucketlist/new'
		else 
			@item = current_user.bucketlist.create(item: params[:item], notes: params[:notes])
			redirect "/bucketlist/#{@item.id}"
		end 
	end
end