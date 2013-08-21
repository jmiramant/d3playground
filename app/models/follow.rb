class Follow < ActiveRecord::Base
  attr_accessible :user_id_one, :user_id_two

  belongs_to :user

end


