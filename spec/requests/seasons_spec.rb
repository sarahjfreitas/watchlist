require 'rails_helper'

RSpec.describe "/seasons", type: :request do
  let(:show) { Show.create!(name: "Name", year: 2022) }
  let(:valid_attributes) { { number: 1, show_id: show.id } }
  let(:invalid_attributes) { { number: -1 } }
  let(:season) { Season.create! valid_attributes }

  describe "GET /index" do
    before do
      season
      get seasons_url , as: :json
    end

    it "has http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders a successful response" do
      aggregate_failures do
        expect(json.count).to eq(1)
        expect(json.first['id']).to eq(season.id)
      end
    end
  end

  describe "GET /show" do
    before do
      get season_url(season), as: :json
    end

    it "has http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders a successful response" do
      expect(json['id']).to eq(season.id)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      subject { post '/seasons', params: { season: valid_attributes } }

      it "creates a new Season" do
        expect{subject}.to change(Season, :count).by(1)
      end

      it "renders a JSON response with the new season" do
        subject
        aggregate_failures do
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      subject { post '/seasons', params: { season: invalid_attributes } }

      it "does not create a new season" do
        expect{subject}.to change(Season, :count).by(0)
      end

      it "renders a JSON response with errors for the new season" do
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
      subject { patch "/seasons/#{season.id}", params: { season: { number: 4 } } }

      it "updates the requested season" do
        subject
        season.reload

        expect(season.number).to eq(4)
      end

      it "renders a JSON response with the season" do
        subject
        season.reload

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      subject { patch "/seasons/#{season.id}", params: { season: invalid_attributes } }

      it "renders a JSON response with errors for the season" do
        subject
        season.reload

        aggregate_failures do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end
  end

  describe "DELETE /destroy" do
    subject { delete "/seasons/#{season.id}" }

    it "destroys the requested season" do
      season
      expect { subject }.to change(Season, :count).by(-1)
    end
  end
end
