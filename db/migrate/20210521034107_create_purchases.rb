class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :receipt_url
      t.string :payment_intent_id

      t.timestamps
    end
  end
end
