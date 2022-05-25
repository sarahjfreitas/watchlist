require 'rails_helper'

RSpec.describe "/episodes", type: :request do
  let(:show) { Show.create!(name: "Name", year: 2022) }
  let(:season) { Season.create!(number: 1, show: show) }
  let(:valid_attributes) { { name: "Name", number: 1, season_id: season.id } }
  let(:invalid_attributes) { { name: "Name" } }
  let(:episode) { Episode.create! valid_attributes }

  describe "GET /index" do
    before do
      episode
      get episodes_url , as: :json
    end

    it "has http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders a successful response" do
      aggregate_failures do
        expect(json.count).to eq(1)
        expect(json.first['id']).to eq(episode.id)
      end
    end
  end

  describe "GET /show" do
    before do
      get episode_url(episode), as: :json
    end

    it "has http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders a successful response" do
      expect(json['id']).to eq(episode.id)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      subject { post '/episodes', params: { episode: valid_attributes } }

      it "creates a new Episode" do
        expect{subject}.to change(Episode, :count).by(1)
      end

      it "renders a JSON response with the new episode" do
        subject
        aggregate_failures do
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      subject { post '/episodes', params: { episode: invalid_attributes } }

      it "does not create a new Episode" do
        expect{subject}.to change(Episode, :count).by(0)
      end

      it "renders a JSON response with errors for the new episode" do
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
      subject { patch "/episodes/#{episode.id}", params: { episode: { name: "New name" } } }

      it "updates the requested episode" do
        subject
        episode.reload

        expect(episode.name).to eq("New name")
      end

      it "renders a JSON response with the episode" do
        subject
        episode.reload

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      subject { patch "/episodes/#{episode.id}", params: { episode: { name: "" } } }

      it "renders a JSON response with errors for the episode" do
        subject
        episode.reload

        aggregate_failures do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end
  end

  describe "DELETE /destroy" do
    subject { delete "/episodes/#{episode.id}" }

    it "destroys the requested episode" do
      episode
      expect { subject }.to change(Episode, :count).by(-1)
    end
  end
end
