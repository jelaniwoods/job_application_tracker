class JobApplication < ApplicationRecord
  # Direct associations

  has_many   :interviews,
             dependent: :destroy

  belongs_to :company

  belongs_to :user

  # Indirect associations

  # Validations

  validates :status, presence: true

  validates :status,
            inclusion: { in: ["not started", "working on", "applied",
                              "denied"] }

  validates :title, presence: true

  # Scopes

  def to_s
    title
  end
end
