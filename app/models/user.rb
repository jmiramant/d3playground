class User < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :profile_score, :company_id, :location

	belongs_to :company
	has_many :follows

	def top_fitscore_matches
		score = self.profile_score
		matches = User.where(profile_score:(score-10)..(score+10)).limit(15)
		render_api matches, score
	end

	def top_company_matches
		score = self.profile_score
		company_matches = Company.where(profile_score: (user_score-10)..(user_score+10)).limit(15)
		render_api company_matches, score
	end

	def render_api matches, score 
		api,nodes,links = [],[],[]
		target = 0
		matches.each do |match|
			match.last_name ? name = match.first_name + " " + match.last_name : name = match.name 
			nodes << {
				name: name, 
				group: 2, 
				size: (20 - (score - match.profile_score).abs), 
				length: 100, 
				color: '#6BBB96'}
			links << {
				source: 0, 
				target: target}
			target += 1
		end
		nodes.unshift(unique_current_user nodes.first, links.first)
		links.unshift({source: 0, target: target})
		api << nodes
		api << links
	end

	def unique_current_user node, link
		current_user = User.first
		{ name: current_user.first_name + " " + current_user.last_name, 
				group: 2, 
				size: 25, 
				length: 100, 
				color: '#F67965'}
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

