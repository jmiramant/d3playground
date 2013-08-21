class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :profile_score, :company_id, :location

  belongs_to :company
  has_many :follows

  def match_range score, match

  end

  def top_fitscore_matches
		score = self.profile_score
		matches = User.where(profile_score:(score-10)..(score+10)).limit(15)
		api = []
		nodes = []
		links = []
		target = 0
		matches.each do |user|
			nodes << {
					name: user.first_name + " " + user.last_name, 
					group: 2, 
					size: (15 - (score - user.profile_score).abs), 
					length: 100, 
					color: '#6BBB96'}
			links << {
				source: 1, 
				target: target}
			target += 1
		end
		nodes.first[:group] = 1
		nodes.first[:size] = 15
		api << nodes
		api << links
  end

  def top_company_matches
  	user_score = self.profile_score
  	company_matches = Company.where(profile_score: (user_score-10)..(user_score+10)).limit(10)
		api = []
		nodes = []
		links = []
		target = 0
		company_matches.each do |company|
			nodes << {name: company.name, group: 2}
			links << {source: 1, target: target, value: 1}
			target += 1
		end
		nodes.first[:group] = 1
		api << nodes
		api << links
  end

  def top_follower_matches
  	user_score = self.profile_score
  	company_matches = Company.where(profile_score: (user_score-10)..(user_score+10)).limit(10)
		api = []
		nodes = []
		links = []
		matches.each do |company|
			nodes << {name: company.name, group: 2}
			links << {source: 1, target: 0, value: 1}
		end
		nodes.first[:group] = 1
		api << nodes
		api << links
  end

end

