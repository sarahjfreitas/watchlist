require 'rails_helper'

RSpec.describe "/shows", type: :request do
  let(:valid_attributes) { { name: "Name", year: 2000 } }
  let(:invalid_attributes) { { name: "" } }
  let(:show) { Show.create! valid_attributes }

  describe "GET /index" do
    before do
      show
      get shows_url , as: :json
    end

    it "has http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders a successful response" do
      aggregate_failures do
        expect(json.count).to eq(1)
        expect(json.first['id']).to eq(show.id)
      end
    end
  end

  describe "GET /show" do
    before do
      get show_url(show), as: :json
    end

    it "has http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders a successful response" do
      expect(json['id']).to eq(show.id)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      subject { post '/shows', params: { show: valid_attributes } }

      it "creates a new Show" do
        expect{subject}.to change(Show, :count).by(1)
      end

      it "renders a JSON response with the new show" do
        subject
        aggregate_failures do
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      subject { post '/shows', params: { show: invalid_attributes } }

      it "does not create a new Show" do
        expect{subject}.to change(Show, :count).by(0)
      end

      it "renders a JSON response with errors for the new show" do
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
      subject { patch "/shows/#{show.id}", params: { show: { name: "New name" } } }

      before do
        subject
        show.reload
      end

      it "updates the requested show" do
        expect(show.name).to eq("New name")
      end

      it "renders a JSON response with the show" do
        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      subject { patch "/shows/#{show.id}", params: { show: { name: "" } } }

      it "renders a JSON response with errors for the show" do
        subject
        show.reload

        aggregate_failures do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end
  end

  describe "DELETE /destroy" do
    subject { delete "/shows/#{show.id}" }

    it "destroys the requested show" do
      show
      expect { subject }.to change(Show, :count).by(-1)
    end
  end
end
