class CompanyResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :name, :string
  attribute :sector, :string

  # Direct associations

  has_many :job_applications

  # Indirect associations

  has_many :interviews do
    assign_each do |company, interviews|
      interviews.select do |i|
        i.id.in?(company.interviews.map(&:id))
      end
    end
  end

  has_many :interviewed_applicants, resource: UserResource do
    assign_each do |company, users|
      users.select do |u|
        u.id.in?(company.interviewed_applicants.map(&:id))
      end
    end
  end

  filter :user_id, :integer do
    eq do |scope, value|
      scope.eager_load(:interviewed_applicants).where(job_applications: { user_id: value })
    end
  end
end
