class AddLocation < ActiveRecord::Migration
  def up
    add_column :listings, :location, :string
  end

  def down
  end
end
