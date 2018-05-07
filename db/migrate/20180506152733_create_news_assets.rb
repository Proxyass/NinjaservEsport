class CreateNewsAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :news_assets do |t|
      t.attachment :file
      t.belongs_to :news, index: true
      t.timestamps
    end
  end
end
