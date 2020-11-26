class AddExpiredAtToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expired_at, :date, default: -> { 'CURRENT_TIMESTAMP' }, null: false
  end
end
