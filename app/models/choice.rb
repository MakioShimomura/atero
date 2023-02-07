class Choice < ApplicationRecord
  has_many :questions
  validates :text, uniqueness: true
end
