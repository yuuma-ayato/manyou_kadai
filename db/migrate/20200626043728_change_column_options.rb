class ChangeColumnOptions < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :title, :string, null: false, limit: 50
    change_column :tasks, :content, :string, null: false, limit: 255
  end
end
