class AddUserReferenceToJobApplications < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :job_applications, :users
    add_index :job_applications, :user_id
    change_column_null :job_applications, :user_id, false
  end
end
