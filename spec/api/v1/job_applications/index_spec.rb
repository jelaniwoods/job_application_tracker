require "rails_helper"

RSpec.describe "job_applications#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/job_applications", params: params
  end

  describe "basic fetch" do
    let!(:job_application1) { create(:job_application) }
    let!(:job_application2) { create(:job_application) }

    it "works" do
      expect(JobApplicationResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["job_applications"])
      expect(d.map(&:id)).to match_array([job_application1.id,
                                          job_application2.id])
    end
  end
end
