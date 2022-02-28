class InterviewResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :starts_on, :datetime
  attribute :round, :integer
  attribute :completed, :boolean
  attribute :job_application_id, :integer

  # Direct associations

  belongs_to :job_application

  # Indirect associations

  has_one    :company
  has_one    :applicant,
             resource: UserResource

  filter :user_id, :integer do
    eq do |scope, value|
      scope.eager_load(:applicant).where(job_applications: { user_id: value })
    end
  end

  filter :company_id, :integer do
    eq do |scope, value|
      scope.eager_load(:company).where(job_applications: { company_id: value })
    end
  end
end
