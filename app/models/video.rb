class Video < ActiveRecord::Base
  enum rating: [:useless, :boring, :okay, :interesting, :great]

  scope :todo, ->() { where(rating: nil) }
end
