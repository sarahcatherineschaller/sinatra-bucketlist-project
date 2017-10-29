class CreateBucketlist < ActiveRecord::Migration[5.1]
  def change
  	create_table :bucketlists do |t|
  		t.string :item
  		t.integer :user_id
  	end
  end
end
