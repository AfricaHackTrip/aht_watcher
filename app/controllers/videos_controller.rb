class VideosController < ApplicationController
  def index
    @videos = Video.todo.page(params[:page])
  end

  def show
    @video = Video.find params[:id]
    @next = Video.todo.where('id > ?', @video.id).first
    @previous = Video.todo.where('id < ?', @video.id).last
  end

  def update
    @video = Video.find params[:id]
    @video.update params[:video].permit(:description, :rating, :category)
    redirect_to @video
  end
end