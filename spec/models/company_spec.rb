require "rails_helper"

RSpec.describe Company, type: :model do
  describe "Direct Associations" do
    it { should have_many(:job_applications) }
  end

  describe "InDirect Associations" do
    it { should have_many(:interviews) }

    it { should have_many(:interviewed_applicants) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:sector) }
  end
end
