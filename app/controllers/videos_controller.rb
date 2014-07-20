require 'csv'

class VideosController < ApplicationController
  helper_method :tags
  def index
    @videos = Video.todo.page(params[:page])
  end

  def all
    @videos = Video.all.includes(:tags)
    respond_to do |f|
      f.html
      f.csv do
        render text: videos_csv(@videos), content_type: 'text/csv'
      end
    end
  end

  def search
    @videos = Video.tagged_with(params[:tag]).page(params[:page])
  end

  def show
    @video = Video.find params[:id]
    @next = Video.todo.where('id > ?', @video.id).first
    @previous = Video.todo.where('id < ?', @video.id).last
  end

  def update
    @video = Video.find params[:id]
    @video.update params[:video].permit(:description, :rating, :category, :tag_list)
      .merge(username: current_user)
    redirect_to Video.todo.offset(rand(Video.todo.count)).first
  end

  protected

  def videos_csv(videos)
    CSV.generate do |csv|
      csv << %w(Id Filename Description Category Rating Tags)
      videos.each do |v|
        csv << [v.id, v.filename, v.description, v.category,
          v.rating, v.tags.map(&:name).join(', ')]
      end
    end
  end

  def tags
    @tags ||= Video.tag_counts_on(:tags)
  end

end
