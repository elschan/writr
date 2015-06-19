class User < ActiveRecord::Base
  has_many :notes
  has_many :comments
  has_one :watcher, dependent: :destroy
  has_many :user_follows

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  after_create :make_watcher

  def follow_user(user_id_to_follow)
    watcher.follow_user(user_id_to_follow)
  end

  def followed_by
    ids = []
    user_follows.each do |user_follow|
      ids << user_follow.watcher.user_id
    end
    User.find(ids)
  end

  def following
    ids = []
    watcher.user_follows.each do |user_follow|
      ids << user_follow.user_id
    end
    User.find(ids)
  end

  private

  def make_watcher
    Watcher.create(user_id: id)
  end
  
end