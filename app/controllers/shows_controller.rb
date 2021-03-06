class ShowsController < ApplicationController
  def index
    render json: Show.all
  end

  def show
    render json: current_show
  end

  def create
    @show = Show.new(show_params)

    if @show.save
      render json: @show, status: :created
    else
      render json: @show.errors, status: :unprocessable_entity
    end
  end

  def update
    if current_show.update(show_params)
      render json: current_show
    else 
      render json: current_show.errors, status: :unprocessable_entity
    end
  end

  def destroy
    current_show.destroy
  end

  private

  def show_params
    params.require(:show).permit(:name, :year)
  end

  def current_show
    @_show ||= Show.find(params[:id])
  end
end
