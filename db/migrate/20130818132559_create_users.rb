class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :first_name 
    	t.string :last_name
    	t.integer :architect_score
    	t.integer :company_id
    	t.integer :location
      
   	 	t.timestamps
   	end
  end
end
