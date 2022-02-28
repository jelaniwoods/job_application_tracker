require "rails_helper"

RSpec.describe User, type: :model do
  describe "Direct Associations" do
    it { should have_many(:job_applications) }
  end

  describe "InDirect Associations" do
    it { should have_many(:interviews) }

    it { should have_many(:interviewed_companies) }
  end

  describe "Validations" do
  end
end
