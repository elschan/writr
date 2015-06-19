class Watcher < ActiveRecord::Base
  belongs_to :user
  has_many :user_follows, dependent: :destroy

  validates :user_id, presence: true

  def user_ids_currently_following
    ids = []
    user_follows.each do |user_follow|
      ids << user_follow.user_id
    end
    ids
  end

  def follow_user(user_id_to_follow)
    new_follow = UserFollow.new(user_id: user_id_to_follow, watcher_id: id)
    unless new_follow.save
      new_follow.delete
    end
  end
  
end