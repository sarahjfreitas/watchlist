require 'rails_helper'

RSpec.describe "/reviews", type: :request do
  let(:show) { Show.create!(name: "Name", year: 2022) }
  let(:valid_attributes) { { author: "Author", stars: 4, content: "Review content", show_id: show.id } }
  let(:invalid_attributes) { { author: "" } }
  let(:review) { Review.create! valid_attributes }

  describe "GET /index" do
    before do
      review
      get reviews_url , as: :json
    end

    it "has http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders a successful response" do
      aggregate_failures do
        expect(json.count).to eq(1)
        expect(json.first['id']).to eq(review.id)
      end
    end
  end

  describe "GET /show" do
    before do
      get review_url(review), as: :json
    end

    it "has http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders a successful response" do
      expect(json['id']).to eq(review.id)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      subject { post '/reviews', params: { review: valid_attributes } }

      it "creates a new Review" do
        expect{subject}.to change(Review, :count).by(1)
      end

      it "renders a JSON response with the new review" do
        subject
        aggregate_failures do
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      subject { post '/reviews', params: { review: invalid_attributes } }

      it "does not create a new review" do
        expect{subject}.to change(Review, :count).by(0)
      end

      it "renders a JSON response with errors for the new review" do
        subject
        aggregate_failures do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      subject { patch "/reviews/#{review.id}", params: { review: { author: 'New author' } } }

      it "updates the requested review" do
        subject
        review.reload

        expect(review.author).to eq('New author')
      end

      it "renders a JSON response with the review" do
        subject
        review.reload

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      subject { patch "/reviews/#{review.id}", params: { review: invalid_attributes } }

      it "renders a JSON response with errors for the review" do
        subject
        review.reload

        aggregate_failures do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end
  end

  describe "DELETE /destroy" do
    subject { delete "/reviews/#{review.id}" }

    it "destroys the requested review" do
      review
      expect { subject }.to change(Review, :count).by(-1)
    end
  end
end
