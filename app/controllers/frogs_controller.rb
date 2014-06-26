class FrogsController < ApplicationController
	def show
		@frog = Frog.find(params[:id])
	end
	def new #get request
		@frog = Frog.new
		@ponds = Pond.all
	end
	def create #post request
		@frog = Frog.new(frog_params)
		if @frog.save
			redirect_to frog_path(@frog) 
		else
			redirect_to new_frog_path 
		end
	end
	def edit #get request
		@frog = Frog.find(params[:id])
		@ponds = Pond.all
	end
	def update #post request
		@frog = Frog.find(params[:id])
		@frog.assign_attributes(frog_params)
		if @frog.save
			redirect_to frog_path(@frog)
		else
			redirect_to frogs_path
		end
	end
	def index
		@frogs = Frog.all
		respond_to do |format|
			format.html #index.html.erb
			format.json {render json: @frogs}
		end
	end
	def destroy
		@frog = Frog.find(params[:id])
		@frog.destroy
		redirect_to frogs_path
	end	
	private 
		def frog_params
			params.require(:frog).permit(:name, :color, :pond_id)
		end
end
