class WatchesController < ApplicationController
  before_action :set_watch, only: [:show, :update, :destroy]

  def index
    render json: Watch.all
  end

  def show
    render json: watch
  end

  def create
    @watch = Watch.new(watch_params)

    if @watch.save
      render json: @watch, status: :created, location: @watch
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  def update
    if watch.update(watch_params)
      render json: @watch
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @watch.destroy
  end

  private

  def watch
    @_watch ||= Watch.find(params[:id])
  end

  def watch_params
    params.require(:watch).permit(:show_id, :last_episode_id, :priority)
  end
end
