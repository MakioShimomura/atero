class Choice < ApplicationRecord
  has_many :questions, dependent: :destroy
  validates :text, presence: true, uniqueness: true
end
