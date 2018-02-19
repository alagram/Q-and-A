class Answer < ApplicationRecord
  include Friendlyable

  belongs_to :question
  belongs_to :user

  validates :body, :presence => true
end
