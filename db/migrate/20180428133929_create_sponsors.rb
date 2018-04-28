class CreateSponsors < ActiveRecord::Migration[5.1]
  def change
    create_table :sponsors do |t|
      t.string :name
      t.boolean :visible
      t.boolean :in_header
      t.text :url
      t.text :description
      t.timestamps
    end
  end
end
