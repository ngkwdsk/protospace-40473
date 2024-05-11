class PrototypesController < ApplicationController
	before_action :authenticate_user!, except: [:show, :index]

	def index
		@prototypes = Prototype.all
	end

	def show
		@prototype = Prototype.find(params[:id])
		@comment = Comment.new
		@comments = @prototype.comments
	end
	
	def new
		@prototype = Prototype.new
	end

	def create
		if Prototype.create(prototype_params)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
		end
	end

	def edit
		@prototype = Prototype.find(params[:id])
		unless @prototype.user == current_user
			redirect_to action: :index
		end
	end

	def update
		prototype = Prototype.find(params[:id])
		if prototype.update(prototype_params)
			redirect_to prototype_path
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@prototype = Prototype.find(params[:id])
		@prototype.destroy
		redirect_to root_path
	end

	private
	
	def prototype_params
		params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
	end

end
