class ChangeColName < ActiveRecord::Migration
  def up
    remove_column :listings, :price_per_sqft
    add_column :listings, :price_per_bedroom, :float
  end

  def down
  end
end
