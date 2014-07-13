class Video < ActiveRecord::Base
  enum rating: [:useless, :boring, :okay, :interesting, :great]
  acts_as_taggable

  scope :todo, ->() { where(rating: nil) }
  scope :done, ->() { where('videos.rating IS NOT NULL') }
end
