require "rails_helper"

RSpec.describe "companies#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/companies/#{company.id}"
  end

  describe "basic destroy" do
    let!(:company) { create(:company) }

    it "updates the resource" do
      expect(CompanyResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { Company.count }.by(-1)
      expect { company.reload }.
        to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq("meta" => {})
    end
  end
end
