class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :authentication_token, unique: true
      t.string :code, null: false, unique: true
      t.string :ip_address

      t.timestamps
    end
  end
end
