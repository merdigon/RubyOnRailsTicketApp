class AddImageSrcToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :image_src, :string
  end
end
