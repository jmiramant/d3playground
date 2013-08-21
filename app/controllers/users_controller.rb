class UsersController < ApplicationController
	# include UsersHelper
	CURRENT_USER = User.first #placeholder for sessions current_user that doesn't exist in this sample app

	def index
	end

	def fitscore_match
		render_api CURRENT_USER.top_fitscore_matches
	end

	def company_match
		render_api CURRENT_USER.top_company_matches
	end

	def following_match
		render_api CURRENT_USER.top_follower_matches
	end

	def render_api data
		@api = {nodes: data[0], links: data[1]}
		render json: @api.to_json
	end

end


