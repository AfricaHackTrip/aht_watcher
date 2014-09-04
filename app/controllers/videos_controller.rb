require 'csv'

class VideosController < ApplicationController
  helper_method :tags

  def index
    @videos = Video.phase2_todo.page(params[:page])
  end

  def phase1
    @videos = Video.phase1_todo.page(params[:page])
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
  end

  def show_phase1
    @video = Video.find params[:id]
    @next = Video.phase1_todo.where('id > ?', @video.id).first
    @previous = Video.phase1_todo.where('id < ?', @video.id).last
  end

  def update_phase1
    @video = Video.find params[:id]
    @video.update params[:video].permit(:description, :rating, :category, :tag_list)
      .merge(username: current_user)
    redirect_to show_phase1_path(Video.phase1_todo.offset(rand(Video.phase1_todo.count)).first)
  end

  def update
    @video = Video.find params[:id]
    @video.update params[:video].permit(:description)
      .merge(username: current_user, chapters: params[:video][:chapters].select(&:present?))
    redirect_to video_path(Video.phase2_todo.offset(rand(Video.phase2_todo.count)).first)
  end

  protected

  def videos_csv(videos)
    CSV.generate(col_sep: ";") do |csv|
      csv << %w(Id Filename Description Chapter Category Rating Tags)
      videos.each do |v|
        csv << [v.id, v.filename, v.description, v.chapters.join(', '), v.category,
          v.rating, v.tags.map(&:name).join(', ')]
      end
    end
  end

  def tags
    @tags ||= Video.tag_counts_on(:tags)
  end

end
