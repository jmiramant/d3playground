class Company < ActiveRecord::Base
  attr_accessible :name, :profile_score, :industry, :size

  has_many :users

end


