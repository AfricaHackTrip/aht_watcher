class Video < ActiveRecord::Base
  enum rating: [:useless, :boring, :okay, :interesting, :great]
  acts_as_taggable

  scope :phase1_todo, ->() { where(rating: nil) }
  scope :phase1_done, ->() { where('videos.rating IS NOT NULL') }

  scope :phase2_todo, ->() { where('videos.rating >= 2 AND array_length(videos.chapters, 1) IS NULL') }
  scope :phase2_done, ->() { where('array_length(videos.chapters, 1) IS NOT NULL') }

  def self.chapters
    ['Intro', 'History/Background', 'Team/Events/Trip', 'Hubs & Community',
      'Education', 'Products', 'Recap', 'Credits']
  end
end
