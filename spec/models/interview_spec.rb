require "rails_helper"

RSpec.describe Interview, type: :model do
  describe "Direct Associations" do
    it { should belong_to(:job_application) }
  end

  describe "InDirect Associations" do
    it { should have_one(:company) }

    it { should have_one(:applicant) }
  end

  describe "Validations" do
  end
end
