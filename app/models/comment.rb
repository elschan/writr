class Comment < ActiveRecord::Base
  belongs_to :note
  belongs_to :user

  validates :note_id, presence: true
  validates :text, presence: true

  validate :cannot_set_comment_type_on_own_note

  private

  def cannot_set_comment_type_on_own_note
    if user_id
      if note.user.id == user_id && vote_kind != nil
        errors.add(:vote_kind, "cannot set type when commenting on own note")
      end
    end
  end

end