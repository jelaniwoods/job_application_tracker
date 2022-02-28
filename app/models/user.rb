class User < ApplicationRecord
  include JwtToken
  # Direct associations

  has_many   :job_applications,
             dependent: :destroy

  # Indirect associations

  has_many   :interviews,
             through: :job_applications,
             source: :interviews

  has_many   :interviewed_companies,
             through: :interviews,
             source: :company

  # Validations

  # Scopes

  def to_s
    email
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
