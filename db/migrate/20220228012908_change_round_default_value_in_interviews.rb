class ChangeRoundDefaultValueInInterviews < ActiveRecord::Migration[6.0]
  def change
    change_column_default :interviews, :round, "1"
  end
end
