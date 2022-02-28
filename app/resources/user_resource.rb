class UserResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :email, :string
  attribute :password, :string

  # Direct associations

  has_many :job_applications

  # Indirect associations

  has_many :interviews do
    assign_each do |user, interviews|
      interviews.select do |i|
        i.id.in?(user.interviews.map(&:id))
      end
    end
  end

  has_many :interviewed_companies, resource: CompanyResource do
    assign_each do |user, companies|
      companies.select do |c|
        c.id.in?(user.interviewed_companies.map(&:id))
      end
    end
  end

  filter :company_id, :integer do
    eq do |scope, value|
      scope.eager_load(:interviewed_companies).where(job_applications: { company_id: value })
    end
  end
end
