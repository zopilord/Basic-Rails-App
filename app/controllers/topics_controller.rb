class TopicsController < ApplicationController
  def index
  	@topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
  end

  def show
  	@topic = Topic.find(params[:id])
  	authorize! :read, @topic, message: "You need to be signed-in to do that"
  	@posts = @topic.posts.paginate(page: params[:page], per_page: 10)
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
		name = @topic.name
		authorize! :destroy, @topic, message: "You need to own the topic to delete it"
		if @topic.destroy
			flash[:notice] = "\"#{name}\" was deleted succesfully."
			redirect_to topics_path
		else
			flash[:error] = "There was a problem deleting the topic."	
			render :show
		end
	end
end
