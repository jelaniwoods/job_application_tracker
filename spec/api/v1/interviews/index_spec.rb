require "rails_helper"

RSpec.describe "interviews#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/interviews", params: params
  end

  describe "basic fetch" do
    let!(:interview1) { create(:interview) }
    let!(:interview2) { create(:interview) }

    it "works" do
      expect(InterviewResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["interviews"])
      expect(d.map(&:id)).to match_array([interview1.id, interview2.id])
    end
  end
end
