class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :rating
      t.string :reviews
      t.belongs_to :property
      t.belongs_to :renter
      t.timestamps
    end
  end
end
