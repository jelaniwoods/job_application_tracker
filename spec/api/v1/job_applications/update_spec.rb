require "rails_helper"

RSpec.describe "job_applications#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/job_applications/#{job_application.id}", payload
  end

  describe "basic update" do
    let!(:job_application) { create(:job_application) }

    let(:payload) do
      {
        data: {
          id: job_application.id.to_s,
          type: "job_applications",
          attributes: {
            # ... your attrs here
          },
        },
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit "updates the resource" do
      expect(JobApplicationResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { job_application.reload.attributes }
    end
  end
end
