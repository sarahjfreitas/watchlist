class EpisodesController < ApplicationController
  def index
    render json: Episode.all
  end

  def show
    render json: episode
  end

  def create
    @episode = Episode.new(episode_params)

    if @episode.save
      render json: @episode, status: :created
    else
      render json: @episode.errors, status: :unprocessable_entity
    end
  end

  def update
    if episode.update(episode_params)
      render json: episode
    else
      render json: episode.errors, status: :unprocessable_entity
    end
  end

  def destroy
    episode.destroy
  end

  private

  def episode_params
    params.require(:episode).permit(:name, :number, :season_id)
  end

  def episode
    @_episode ||= episode.find(params[:id])
  end
end
