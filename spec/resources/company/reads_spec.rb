require "rails_helper"

RSpec.describe CompanyResource, type: :resource do
  describe "serialization" do
    let!(:company) { create(:company) }

    it "works" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(company.id)
      expect(data.jsonapi_type).to eq("companies")
    end
  end

  describe "filtering" do
    let!(:company1) { create(:company) }
    let!(:company2) { create(:company) }

    context "by id" do
      before do
        params[:filter] = { id: { eq: company2.id } }
      end

      it "works" do
        render
        expect(d.map(&:id)).to eq([company2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:company1) { create(:company) }
      let!(:company2) { create(:company) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      company1.id,
                                      company2.id,
                                    ])
        end
      end

      context "when descending" do
        before do
          params[:sort] = "-id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      company2.id,
                                      company1.id,
                                    ])
        end
      end
    end
  end

  describe "sideloading" do
    # ... your tests ...
  end
end
