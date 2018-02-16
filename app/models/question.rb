class Question < ApplicationRecord
  include Friendlyable
  belongs_to :user
  has_many :answers, -> { order("created_at DESC") }

  validates :title, :presence => true
  validates :body, :presence => true

  searchkick  text_start: [:title]

  def search_data
    {
      title: title,
      body: body
    }
  end
end
