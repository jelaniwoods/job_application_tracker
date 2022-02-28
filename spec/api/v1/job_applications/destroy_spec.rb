require "rails_helper"

RSpec.describe "job_applications#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/job_applications/#{job_application.id}"
  end

  describe "basic destroy" do
    let!(:job_application) { create(:job_application) }

    it "updates the resource" do
      expect(JobApplicationResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { JobApplication.count }.by(-1)
      expect { job_application.reload }.
        to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq("meta" => {})
    end
  end
end
