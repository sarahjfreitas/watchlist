class EpisodesController < ApplicationController
  def index
    render json: Episode.all
  end

  def show
    render json: episode
  end

  def create
    Episode.create(episode_params)
    render json: "episode #{episode_params.number} has been created."
  end

  def update
    episode.update(episode_params)
    render json: "episode #{episode.number} has been updated."
  end

  def destroy
    episode.destroy
    render json: "episode #{episode.number} has been destroyed."
  end

  private

  def episode_params
    params.require(:name, :number)
  end

  def episode
    @_episode ||= episode.find(params[:id])
  end
end
