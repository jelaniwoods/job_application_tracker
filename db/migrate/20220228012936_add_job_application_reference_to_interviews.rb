class AddJobApplicationReferenceToInterviews < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :interviews, :job_applications
    add_index :interviews, :job_application_id
    change_column_null :interviews, :job_application_id, false
  end
end
