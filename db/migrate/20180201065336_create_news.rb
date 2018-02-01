class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.string :title
      t.string :caption
      t.text :content
      t.boolean :visible
      t.belongs_to :user
      t.timestamps
    end
  end
end
