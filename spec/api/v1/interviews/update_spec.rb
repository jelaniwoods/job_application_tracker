require "rails_helper"

RSpec.describe "interviews#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/interviews/#{interview.id}", payload
  end

  describe "basic update" do
    let!(:interview) { create(:interview) }

    let(:payload) do
      {
        data: {
          id: interview.id.to_s,
          type: "interviews",
          attributes: {
            # ... your attrs here
          },
        },
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit "updates the resource" do
      expect(InterviewResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { interview.reload.attributes }
    end
  end
end
