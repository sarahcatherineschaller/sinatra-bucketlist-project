class User < ActiveRecord::Base 
	has_many :bucket_lists 
	has_secure_password 
end