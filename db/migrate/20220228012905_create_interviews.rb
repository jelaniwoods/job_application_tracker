class CreateInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :interviews do |t|
      t.datetime :starts_on
      t.integer :round
      t.boolean :completed
      t.integer :job_application_id

      t.timestamps
    end
  end
end
