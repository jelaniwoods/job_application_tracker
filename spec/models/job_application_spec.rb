require "rails_helper"

RSpec.describe JobApplication, type: :model do
  describe "Direct Associations" do
    it { should have_many(:interviews) }

    it { should belong_to(:company) }

    it { should belong_to(:user) }
  end

  describe "InDirect Associations" do
  end

  describe "Validations" do
    it { should validate_presence_of(:status) }

    it {
      should validate_inclusion_of(:status).in_array(["not started", "working on",
                                                      "applied", "denied"])
    }

    it { should validate_presence_of(:title) }
  end
end
