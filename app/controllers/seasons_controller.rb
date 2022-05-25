class SeasonsController < ApplicationController
  def index
    render json: Season.all
  end

  def show
    render json: season
  end

  def create
    @season = Season.new(season_params)

    if @season.save
      render json: @season, status: :created
    else
      render json: @season.errors, status: :unprocessable_entity
    end
  end

  def update
    if season.update(season_params)
      render json: season
    else
      render json: season.errors, status: :unprocessable_entity
    end
  end

  def destroy
    season.destroy
  end

  private

  def season_params
    params.permit(:number, :show_id, :description)
  end

  def season
    @_season ||= Season.find(params[:id])
  end
end
