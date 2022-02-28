require "rails_helper"

RSpec.describe JobApplicationResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "job_applications",
          attributes: {},
        },
      }
    end

    let(:instance) do
      JobApplicationResource.build(payload)
    end

    it "works" do
      expect do
        expect(instance.save).to eq(true),
                                 instance.errors.full_messages.to_sentence
      end.to change { JobApplication.count }.by(1)
    end
  end

  describe "updating" do
    let!(:job_application) { create(:job_application) }

    let(:payload) do
      {
        data: {
          id: job_application.id.to_s,
          type: "job_applications",
          attributes: {}, # Todo!
        },
      }
    end

    let(:instance) do
      JobApplicationResource.find(payload)
    end

    xit "works (add some attributes and enable this spec)" do
      expect do
        expect(instance.update_attributes).to eq(true)
      end.to change { job_application.reload.updated_at }
      # .and change { job_application.foo }.to('bar') <- example
    end
  end

  describe "destroying" do
    let!(:job_application) { create(:job_application) }

    let(:instance) do
      JobApplicationResource.find(id: job_application.id)
    end

    it "works" do
      expect do
        expect(instance.destroy).to eq(true)
      end.to change { JobApplication.count }.by(-1)
    end
  end
end
