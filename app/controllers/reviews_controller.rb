class ReviewsController < ApplicationController
  def index
    render json: Review.all
  end

  def show
    render json: review
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def update
    if review.update(review_params)
      render json: review
    else
      render json: review.errors, status: :unprocessable_entity
    end
  end

  def destroy
    review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:author, :stars, :content, :show_id)
  end

  def review
    @_review ||= Review.find(params[:id])
  end
end
