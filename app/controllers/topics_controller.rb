class TopicsController < ApplicationController
  def index
  	@topic = Topic.all
  end

  def new
  	@topic = Topic.new
  	authorize! :create, @topic, message: "You need to be admin"
  end

  def create
		@topic = Topic.new(params[:topic])
		authorize! :create, @topic, message: "You need to be admin"
		if @topic.save
			redirect_to @topic, notice: "Success"
		else
			render :new
			flash[:error] = "Problem"	
		end
  end

  def show
  	@topic = Topic.find(params[:id])
  	@posts = @topic.posts
  end

  def edit
  	@topic = Topic.find(params[:id])
  	authorize! :update, @topic, message: "You need to be an admin to do that."
  end

  def update
		@topic = Topic.find(params[:id])
		authorize! :update, @topic, message: "You need to own the topic to update it."
		if @topic.update_attributes(params[:topic])
			redirect_to @topic
			flash[:notice] = "Success!"
		else
			flash[:error] = "Problem"
			render :edit		 	
	  end
	end  
	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy
		redirect_to topics_path
	end
end
