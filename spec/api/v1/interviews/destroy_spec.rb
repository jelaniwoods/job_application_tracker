require "rails_helper"

RSpec.describe "interviews#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/interviews/#{interview.id}"
  end

  describe "basic destroy" do
    let!(:interview) { create(:interview) }

    it "updates the resource" do
      expect(InterviewResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { Interview.count }.by(-1)
      expect { interview.reload }.
        to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq("meta" => {})
    end
  end
end
