class VideosController < ApplicationController
  helper_method :tags
  def index
    @videos = Video.todo.page(params[:page])
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
    redirect_to Video.todo.first
  end

  protected
    def tags
      @tags ||= Video.tag_counts_on(:tags)
    end

end
