class AddGMapUrl < ActiveRecord::Migration
  def up
    add_column :listings, :gmap_url, :string
  end

  def down
  end
end
