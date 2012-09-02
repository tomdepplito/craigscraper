class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :date
      t.string :description
      t.string :price_and_sqft
      t.string :link
      t.float :price
      t.integer :beds
      t.float :price_per_sqft

      t.timestamps
    end
  end
end
