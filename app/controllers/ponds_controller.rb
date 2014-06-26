class PondsController < ApplicationController
	def show
		@pond = Pond.find(params[:id])
	end
	def new #get request
		@pond = Pond.new
	end
	def create #post request
		@pond = Pond.new(pond_params)
		if @pond.save
			redirect_to pond_path(@pond) 
		else
			redirect_to new_pond_path 
		end
	end
	def edit #get request
		@pond = Pond.find(params[:id])
	end
	def update #post request
		@pond = Pond.find(params[:id])
		@pond.assign_attributes(pond_params)
		if @pond.save
			redirect_to pond_path(@pond)
		else
			redirect_to pond_path
		end
	end
	def index
		@ponds = Pond.all
		respond_to do |format|
			format.html #index.html.erb
			format.json {render json: @ponds}
		end
	end
	def destroy
		@pond = Pond.find(params[:id])
		@pond.destroy
		redirect_to ponds_path
	end	
	private 
		def pond_params
			params.require(:pond).permit(:name, :water_type)
		end
end
