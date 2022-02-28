require "rails_helper"

RSpec.describe "interviews#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/interviews/#{interview.id}", params: params
  end

  describe "basic fetch" do
    let!(:interview) { create(:interview) }

    it "works" do
      expect(InterviewResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("interviews")
      expect(d.id).to eq(interview.id)
    end
  end
end
