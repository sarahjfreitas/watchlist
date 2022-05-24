class ReviewsController < ApplicationController
  def index
    render json: review.all
  end

  def show
    render json: review
  end

  def create
    review.create(review_params)
    render json: "review from #{review_params.author} has been created."
  end

  def update
    review.update(review_params)
    render json: "review from #{review_params.author} has been updated."
  end

  def destroy
    review.destroy
    render json: "review from #{review_params.author} has been destroyed."
  end

  private

  def review_params
    params.require(:author, :stars, :content, :show_id)
  end

  def review
    @_review ||= review.find(params[:id])
  end
end
