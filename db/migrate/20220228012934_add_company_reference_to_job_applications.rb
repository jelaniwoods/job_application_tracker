class AddCompanyReferenceToJobApplications < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :job_applications, :companies
    add_index :job_applications, :company_id
    change_column_null :job_applications, :company_id, false
  end
end
