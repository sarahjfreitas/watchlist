class ShowsController < ApplicationController
  def index
    render json: Show.all
  end

  def show
    render json: current_show
  end

  def create
    Show.create(show_params)
    render json: "Show #{show_params.name} has been created."
  end

  def update
    current_show.update(show_params)
    render json "#{current_show.name} has been updated."
  end

  def destroy
    current_show.destroy
    render json "#{current_show.name} has been destroyed."
  end

  private

  def show_params
    params.require(:name, :year)
  end

  def current_show
    @_show ||= Show.find(params[:id])
  end
end
