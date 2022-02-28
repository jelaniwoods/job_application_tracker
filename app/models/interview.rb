class Interview < ApplicationRecord
  # Direct associations

  belongs_to :job_application

  # Indirect associations

  has_one    :company,
             through: :job_application,
             source: :company

  has_one    :applicant,
             through: :job_application,
             source: :user

  # Validations

  # Scopes

  def to_s
    starts_on
  end
end
