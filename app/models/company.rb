class Company < ApplicationRecord
  # Direct associations

  has_many   :job_applications,
             dependent: :nullify

  # Indirect associations

  has_many   :interviews,
             through: :job_applications,
             source: :interviews

  has_many   :interviewed_applicants,
             through: :interviews,
             source: :applicant

  # Validations

  validates :name, presence: true

  validates :sector, presence: true

  # Scopes

  def to_s
    name
  end
end
