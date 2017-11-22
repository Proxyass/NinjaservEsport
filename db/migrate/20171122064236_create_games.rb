class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :name
      t.boolean :team_based
      t.text :description
      t.string :image_url
      t.timestamps
    end
  end
end
