class User < ActiveRecord::Migration[7.1]
  def change
    create_table :Users do |t|
      t.string :username
      t.text :email
      t.string :password_digest
      t.timestamps
    end
    
  end
end
