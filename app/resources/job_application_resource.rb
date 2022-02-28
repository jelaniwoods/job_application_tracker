class JobApplicationResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :title, :string
  attribute :due_on, :datetime
  attribute :status, :string
  attribute :user_id, :integer
  attribute :company_id, :integer

  # Direct associations

  has_many   :interviews

  belongs_to :company

  belongs_to :user

  # Indirect associations
end
