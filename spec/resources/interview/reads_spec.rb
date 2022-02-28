require "rails_helper"

RSpec.describe InterviewResource, type: :resource do
  describe "serialization" do
    let!(:interview) { create(:interview) }

    it "works" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(interview.id)
      expect(data.jsonapi_type).to eq("interviews")
    end
  end

  describe "filtering" do
    let!(:interview1) { create(:interview) }
    let!(:interview2) { create(:interview) }

    context "by id" do
      before do
        params[:filter] = { id: { eq: interview2.id } }
      end

      it "works" do
        render
        expect(d.map(&:id)).to eq([interview2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:interview1) { create(:interview) }
      let!(:interview2) { create(:interview) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      interview1.id,
                                      interview2.id,
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
                                      interview2.id,
                                      interview1.id,
                                    ])
        end
      end
    end
  end

  describe "sideloading" do
    # ... your tests ...
  end
end
