require "rails_helper"

RSpec.describe "companies#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/companies/#{company.id}", params: params
  end

  describe "basic fetch" do
    let!(:company) { create(:company) }

    it "works" do
      expect(CompanyResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("companies")
      expect(d.id).to eq(company.id)
    end
  end
end
