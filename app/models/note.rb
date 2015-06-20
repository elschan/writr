class Note < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :user_id, presence: true
  validates :text, presence: true

  def author
    user.username
  end

  def get_votes
    votes_hash = {}
    comments.each do |comment|
      if comment.vote_kind
        if votes_hash[comment.vote_kind.to_sym]
          votes_hash[comment.vote_kind.to_sym] += 1
        else
          votes_hash[comment.vote_kind.to_sym] = 1
        end
      end
    end
    return nil if votes_hash.empty?
    votes_hash
  end
  
end