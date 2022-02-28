class ChangeCompletedDefaultValueInInterviews < ActiveRecord::Migration[6.0]
  def change
    change_column_default :interviews, :completed, "false"
  end
end
