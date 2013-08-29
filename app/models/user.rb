class User < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :architect_score, :company_id, :location

	belongs_to :company

	def top_fitscore_matches
		score = self.architect_score
		matches = User.where(architect_score:(score-10)..(score+10)).limit(15)
		render_api matches, score
	end

	def top_company_matches
		score = self.architect_score
		company_matches = Company.where(architect_score: (score-10)..(score+10)).limit(15)
		render_api company_matches, score
	end

	def render_api matches, score 
		api,nodes,links = [],[],[]
		target = 0
		matches.each do |match|
			match.class.to_s == "User" ? name = match.first_name + " " + match.last_name : name = match.name 
			nodes << {
				name: name,
				fitscore: match.architect_score,
				group: 2,
				fixed: false,
				size: (20 - (score - match.architect_score).abs), 
				color: '#6BBB96'}
			links << {
				source: 0, 
				target: target}
			target += 1
		end
		unique_current_user nodes.first
		api << nodes
		api << links
	end

	def unique_current_user node
		node[:group] = 1
		node[:size] = 25
		node[:fixed] = true
		node[:x] = 370
		node[:y] = 250
		node[:color] = '#F67965'
	end

end

