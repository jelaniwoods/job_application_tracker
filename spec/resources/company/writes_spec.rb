require "rails_helper"

RSpec.describe CompanyResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "companies",
          attributes: {},
        },
      }
    end

    let(:instance) do
      CompanyResource.build(payload)
    end

    it "works" do
      expect do
        expect(instance.save).to eq(true),
                                 instance.errors.full_messages.to_sentence
      end.to change { Company.count }.by(1)
    end
  end

  describe "updating" do
    let!(:company) { create(:company) }

    let(:payload) do
      {
        data: {
          id: company.id.to_s,
          type: "companies",
          attributes: {}, # Todo!
        },
      }
    end

    let(:instance) do
      CompanyResource.find(payload)
    end

    xit "works (add some attributes and enable this spec)" do
      expect do
        expect(instance.update_attributes).to eq(true)
      end.to change { company.reload.updated_at }
      # .and change { company.foo }.to('bar') <- example
    end
  end

  describe "destroying" do
    let!(:company) { create(:company) }

    let(:instance) do
      CompanyResource.find(id: company.id)
    end

    it "works" do
      expect do
        expect(instance.destroy).to eq(true)
      end.to change { Company.count }.by(-1)
    end
  end
end
