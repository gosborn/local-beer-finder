class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.string :db_code
      t.text :description
      t.string :abv
      t.string :ibu
      t.integer :brewery_id
    end
  end
end

