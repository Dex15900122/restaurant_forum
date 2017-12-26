class AddAttributesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :intro, :text
    add_column :users, :avater, :string
  end
end
