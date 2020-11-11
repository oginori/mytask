class RenameDescriotionClumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :descriotion, :description
  end
end
