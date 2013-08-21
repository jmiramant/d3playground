module UsersHelper
	extend self

	def render_api data
		@api = {nodes: data[0], links: data[1]}
		render json: @api.to_json
	end

end
