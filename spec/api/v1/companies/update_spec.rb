require "rails_helper"

RSpec.describe "companies#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/companies/#{company.id}", payload
  end

  describe "basic update" do
    let!(:company) { create(:company) }

    let(:payload) do
      {
        data: {
          id: company.id.to_s,
          type: "companies",
          attributes: {
            # ... your attrs here
          },
        },
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit "updates the resource" do
      expect(CompanyResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { company.reload.attributes }
    end
  end
end
