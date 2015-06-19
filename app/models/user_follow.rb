class UserFollow < ActiveRecord::Base
  belongs_to :watcher
  belongs_to :user

  validates :watcher_id, presence: true
  validates :user_id, presence: true

  validate :not_following_self
  validate :follow_relation_does_not_already_exist
  # validate that the watcher is not already following the user

  private

  def not_following_self
    errors.add(:user_id, "user cannot follow self") if user_id == watcher.user_id
  end

  def follow_relation_does_not_already_exist
    if watcher.user_ids_currently_following.include?(user_id)
      errors.add(:user_id, "follow relation already exists")
    end
  end

end