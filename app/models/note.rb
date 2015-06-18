class Note < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :user_id, presence: true
  validates :text, presence: true

  def author
    user.username
  end
  
end