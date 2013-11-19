class FavoriteMailer < ActionMailer::Base
  default from: "urielcornel@gmail.com"
  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment
    # New Headers
    headers["Message-ID"] = "<comments/#{@comment.id}@zopilord-bloccit.example>"
    headers["In-Reply-To"] = "<post/#{@post.id}@zopilord-bloccit.example>"
    headers["References"] = "<post/#{@post.id}@zopilord-bloccit.example>"
    mail(to: user.email, subject: "New comment on #{post.title}")
    end
end
