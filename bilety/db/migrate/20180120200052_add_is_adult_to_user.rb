class AddIsAdultToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_adult, :boolean
    add_column :users, :is_admin, :boolean, default: false
  end
end
