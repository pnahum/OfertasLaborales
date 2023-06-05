class AddNullToOffers < ActiveRecord::Migration[7.0]
  def change
    change_column :offers, :description, :text, null: false
  end
end
