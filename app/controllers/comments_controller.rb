class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
  	@post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = @post.comments.build(params[:comment])
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
end 