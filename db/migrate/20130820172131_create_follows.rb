class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
    	t.integer :user_id_one
    	t.integer :user_id_two
    end
  end
end
