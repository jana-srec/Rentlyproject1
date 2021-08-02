class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address
      t.string :city
      t.integer :rent
      t.integer :bedrooms
      t.string :description
      t.integer :flag
      t.belongs_to :agent

      t.timestamps
    end
  end
end
