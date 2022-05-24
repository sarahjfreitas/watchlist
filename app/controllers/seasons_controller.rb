class SeasonsController < ApplicationController
  def index
    render json: Season.all
  end

  def show
    render json: season
  end

  def create
    Season.create(season_params)
    render json: "Season #{season_params.number} has been created."
  end

  def update
    season.update(season_params)
    render json: "Season #{season.number} has been updated."
  end

  def destroy
    season.destroy
    render json: "Season #{season.number} has been destroyed."
  end

  private

  def season_params
    params.require(:number, :show_id).permit(:description)
  end

  def season
    @_season ||= Season.find(params[:id])
  end
end
