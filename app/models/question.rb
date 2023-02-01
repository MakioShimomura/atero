class Question < ApplicationRecord
  belongs_to :answer
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
end
