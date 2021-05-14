class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.string :category
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
