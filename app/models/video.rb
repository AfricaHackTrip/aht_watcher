class Video < ActiveRecord::Base
  enum rating: [:useless, :boring, :okay, :interesting, :great]

  scope :todo, ->() { where(rating: nil) }
  scope :done, ->() { where('videos.rating IS NOT NULL') }
end
