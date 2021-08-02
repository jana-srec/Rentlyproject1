class CreateWishlists < ActiveRecord::Migration[6.1]
  def change
    create_table :wishlists do |t|
      t.belongs_to :renter
      t.belongs_to :property
      t.timestamps
    end
  end
end
