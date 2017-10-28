class CreateBucketlist < ActiveRecord::Migration[5.1]
  def change
  	create_table :bucketlist do |t|
  		t.string :item
  		t.string :notes
  		t.integer :user_id
  	end
  end
end
