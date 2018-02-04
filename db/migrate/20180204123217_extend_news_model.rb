class ExtendNewsModel < ActiveRecord::Migration[5.1]
  def change
    add_column :news, :beauty_url, :string
    add_column :news, :image_url, :string
  end
end
