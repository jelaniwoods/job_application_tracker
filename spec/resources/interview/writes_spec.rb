require "rails_helper"

RSpec.describe InterviewResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "interviews",
          attributes: {},
        },
      }
    end

    let(:instance) do
      InterviewResource.build(payload)
    end

    it "works" do
      expect do
        expect(instance.save).to eq(true),
                                 instance.errors.full_messages.to_sentence
      end.to change { Interview.count }.by(1)
    end
  end

  describe "updating" do
    let!(:interview) { create(:interview) }

    let(:payload) do
      {
        data: {
          id: interview.id.to_s,
          type: "interviews",
          attributes: {}, # Todo!
        },
      }
    end

    let(:instance) do
      InterviewResource.find(payload)
    end

    xit "works (add some attributes and enable this spec)" do
      expect do
        expect(instance.update_attributes).to eq(true)
      end.to change { interview.reload.updated_at }
      # .and change { interview.foo }.to('bar') <- example
    end
  end

  describe "destroying" do
    let!(:interview) { create(:interview) }

    let(:instance) do
      InterviewResource.find(id: interview.id)
    end

    it "works" do
      expect do
        expect(instance.destroy).to eq(true)
      end.to change { Interview.count }.by(-1)
    end
  end
end
