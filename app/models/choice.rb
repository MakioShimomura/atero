class Choice < ApplicationRecord
  has_many :questions, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :text, presence: true, uniqueness: true
end
