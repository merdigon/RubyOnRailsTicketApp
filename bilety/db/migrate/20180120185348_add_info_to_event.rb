class AddInfoToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :is_adult_only, :boolean
    add_column :events, :places_limit, :integer
  end
end
