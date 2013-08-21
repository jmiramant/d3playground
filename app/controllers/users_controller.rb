class UsersController < ApplicationController
	CURRENT_USER = User.first #placeholder for sessions current_user that doesn't exist in this sample app
	
	def index
	end

	def fitscore_match
		data = CURRENT_USER.top_fitscore_matches
		@api = {nodes: data[0], links: data[1]}
		render json: @api.to_json
	end

	def company_match
		data = CURRENT_USER.top_company_matches
		@api = {nodes: data[0], links: data[1]}
		render json: @api.to_json
	end

	def following_match
		data = CURRENT_USER.top_follower_matches
		@api = {nodes: data[0], links: data[1]}
		render json: @api.to_json
	end

end


