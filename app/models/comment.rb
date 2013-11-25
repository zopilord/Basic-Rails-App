class Comment < ActiveRecord::Base
  default_scope order('updated_at DESC')
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :post
  after_create :send_favorite_emails
  validates :user, presence: true
  private
    def send_favorite_emails
      self.post.favorites.each do |favorite|
        if favorite.user_id != self.user_id && favorite.user.email_favorites?
          FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
        end  
      end
    end
end
