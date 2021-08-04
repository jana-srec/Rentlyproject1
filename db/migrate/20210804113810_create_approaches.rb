class CreateApproaches < ActiveRecord::Migration[6.1]
  def change
    create_table :approaches do |t|
      t.references :properties, null: false, foreign_key: true
      t.references :renters, null: false, foreign_key: true
      t.integer :approachflag
      t.timestamps
    end
  end
end
