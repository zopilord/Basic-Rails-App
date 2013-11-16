class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
  	@post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
  	authorize! :create, Comment, message: "You need to be a member to post a comment"
		if @comment.save
      flash[:notice] = "comment was posted."
			redirect_to [@topic, @post]
		else
			flash[:error] = "There was an error posting the comment. Please try again"
			render root	
		end	
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])  
    authorize! :destroy, @comment, message: "You need to own the comment to delete it."
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to [@topic, @post]
    end
  end
end 