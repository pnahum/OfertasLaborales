class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :integer, default: 0
    add_column :users, :image, :string
    add_column :users, :description, :text
  end
end
