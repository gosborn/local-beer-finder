class CreateBreweries < ActiveRecord::Migration
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :db_code
      t.text :address
      t.string :logo
      t.integer :state_id
    end
  end
end
