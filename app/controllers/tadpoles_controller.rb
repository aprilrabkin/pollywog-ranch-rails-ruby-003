class TadpolesController < ApplicationController
	def set_tadpole
		@tadpole = Tadpole.find(params[:id])
	end
	def show
		set_tadpole
	end
	def new #get request
		@frog = Frog.find(params[:frog_id])
		@tadpole = Tadpole.new
	end
	def create #post request
		@tadpole = Tadpole.new(tadpole_params)
		if @tadpole.save
			redirect_to tadpole_path(@tadpole) 
		else
			redirect_to new_tadpole_path 
		end
	end
	def edit #get request
		set_tadpole
		@frogs = Frog.all
	end
	def update #post request
		set_tadpole
		@tadpole.assign_attributes(tadpole_params)
		if @tadpole.save
			redirect_to tadpole_path(@tadpole)
		else
			redirect_to tadpoles_path
		end
	end
	def index
		@tadpoles = Tadpole.all
		respond_to do |format|
			format.html #index.html.erb
			format.json {render json: @tadpoles}
		end
	end
	def destroy
		set_tadpole
		@tadpole.destroy
		redirect_to tadpoles_path
	end	
	def evolve
		@tadpole = Tadpole.find(params[:tadpole_id])
		@frog = @tadpole.evolve
 		if @frog 
      redirect_to frog_path(@frog)
    else
      redirect_to tadpole_path(@tadpole)
    end
  end
	private 
		def tadpole_params
			params.require(:tadpole).permit(:name, :color, :frog_id)
		end
end
