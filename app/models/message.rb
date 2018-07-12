class Message < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  scope :for_display, -> { order(:created_at).last(50) }

  def mentions
    content.scan(/@(#{User::NAME_REGEX})/).flatten.map do |username|
      { 
        mentioner: User.find(user_id),
        mentionee: User.find_by(username: username)
      }
    end.compact
  end
end
