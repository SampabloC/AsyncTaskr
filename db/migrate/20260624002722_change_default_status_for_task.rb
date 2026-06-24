class ChangeDefaultStatusForTask < ActiveRecord::Migration[8.1]
  def change
    change_column_default :tasks, :status, from: nil, to: "pending"
  end
end
