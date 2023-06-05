class AddDetailsToOffers < ActiveRecord::Migration[7.0]
  def change
    change_column :offers, :name, :string, null: false
  end
end
