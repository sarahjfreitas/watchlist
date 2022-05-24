class ShowsController < ApplicationController
  def index
    render json: Show.all
  end

  def show
    render json: show
  end

  def create
    show = Show.create(show_params)
  end

  def update
    show.update(show_params)
    render json "#{show.name} has been updated."
  end

  def destroy
    show.destroy
    render json "#{show.name} has been destroyedß."
  end

  private

  def show_params
    params.require(:name, :year)
  end

  def show
    @_show ||= Show.find(params[:id])
  end
end
