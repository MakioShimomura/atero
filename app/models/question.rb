class Question < ApplicationRecord
  belongs_to :choice
  has_many_attached :images do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
end
