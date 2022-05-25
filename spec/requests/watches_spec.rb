require 'rails_helper'

RSpec.describe "/watches", type: :request do
  let(:show) { Show.create!(name: "Name", year: 2022) }
  let(:season) { Season.create!(number: 1, show: show) }
  let(:episode) { Episode.create!(name: "Name", number: 1, season: season) }
  let(:valid_attributes) { { priority: "Low", show_id: show.id, last_episode_id: episode.id } }
  let(:invalid_attributes) { { priority: nil } }
  let(:watch) { Watch.create! valid_attributes }

  describe "GET /index" do
    before do
      watch
      get watches_url , as: :json
    end

    it "has http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders a successful response" do
      aggregate_failures do
        expect(json.count).to eq(1)
        expect(json.first['id']).to eq(watch.id)
      end
    end
  end

  describe "GET /show" do
    before do
      get watch_url(watch), as: :json
    end

    it "has http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders a successful response" do
      expect(json['id']).to eq(watch.id)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      subject { post '/watches', params: { watch: valid_attributes } }

      it "creates a new Watch" do
        expect{subject}.to change(Watch, :count).by(1)
      end

      it "renders a JSON response with the new watch" do
        subject
        aggregate_failures do
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      subject { post '/watches', params: { watch: invalid_attributes } }

      it "does not create a new Watch" do
        expect{subject}.to change(Watch, :count).by(0)
      end

      it "renders a JSON response with errors for the new watch" do
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
      subject { patch "/watches/#{watch.id}", params: { watch: { priority: "High" } } }

      it "updates the requested watch" do
        subject
        watch.reload

        expect(watch.priority).to eq("High")
      end

      it "renders a JSON response with the watch" do
        subject
        watch.reload

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      subject { patch "/watches/#{watch.id}", params: { watch: invalid_attributes } }

      it "renders a JSON response with errors for the watch" do
        subject
        watch.reload

        aggregate_failures do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end
  end

  describe "DELETE /destroy" do
    subject { delete "/watches/#{watch.id}" }

    it "destroys the requested watch" do
      watch
      expect { subject }.to change(Watch, :count).by(-1)
    end
  end
end
