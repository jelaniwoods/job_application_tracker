require "rails_helper"

RSpec.describe JobApplicationResource, type: :resource do
  describe "serialization" do
    let!(:job_application) { create(:job_application) }

    it "works" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(job_application.id)
      expect(data.jsonapi_type).to eq("job_applications")
    end
  end

  describe "filtering" do
    let!(:job_application1) { create(:job_application) }
    let!(:job_application2) { create(:job_application) }

    context "by id" do
      before do
        params[:filter] = { id: { eq: job_application2.id } }
      end

      it "works" do
        render
        expect(d.map(&:id)).to eq([job_application2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:job_application1) { create(:job_application) }
      let!(:job_application2) { create(:job_application) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      job_application1.id,
                                      job_application2.id,
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
                                      job_application2.id,
                                      job_application1.id,
                                    ])
        end
      end
    end
  end

  describe "sideloading" do
    # ... your tests ...
  end
end
