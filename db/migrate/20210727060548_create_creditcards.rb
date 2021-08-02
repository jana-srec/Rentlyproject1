class CreateCreditcards < ActiveRecord::Migration[6.1]
  def change
    create_table :creditcards do |t|
      t.string :name
      t.integer :cvv
      t.integer :month
      t.integer :expirymonth
      t.belongs_to :renter
      t.timestamps
    end
  end
end
