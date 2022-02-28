require "rails_helper"

RSpec.describe "job_applications#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/job_applications/#{job_application.id}", params: params
  end

  describe "basic fetch" do
    let!(:job_application) { create(:job_application) }

    it "works" do
      expect(JobApplicationResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("job_applications")
      expect(d.id).to eq(job_application.id)
    end
  end
end
