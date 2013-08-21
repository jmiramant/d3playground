class Company < ActiveRecord::Base
  attr_accessible :name, :architect_score, :industry, :size, :location

  has_many :users

end


