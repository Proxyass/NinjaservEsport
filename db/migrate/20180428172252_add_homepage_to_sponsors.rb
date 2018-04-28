class AddHomepageToSponsors < ActiveRecord::Migration[5.1]
  def change
    add_column :sponsors, :homepage, :boolean, :default => false
  end
end
