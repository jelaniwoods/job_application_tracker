require "rails_helper"

RSpec.describe "companies#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/companies", params: params
  end

  describe "basic fetch" do
    let!(:company1) { create(:company) }
    let!(:company2) { create(:company) }

    it "works" do
      expect(CompanyResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["companies"])
      expect(d.map(&:id)).to match_array([company1.id, company2.id])
    end
  end
end
