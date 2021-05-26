class AddSuburbToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :suburb, :string
  end
end
