class AddFieldToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :access_token, :string
    add_column :users, :consumer_secret_key, :string
    add_column :users, :consumer_key, :string
    add_column :users, :access_secret_token, :string
  end
end
