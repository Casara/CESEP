class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.column :id, :'bigserial primary key'

      t.string :name, null: false
      t.string :address
      t.integer :number
      t.string :complement
      t.string :district
      t.string :postal_code
      t.string :city
      t.string :landline
      t.string :phone
      t.boolean :scholarship, null: false, default: false
      t.string :matriculation
      t.string :shift_work, null: false
      t.text :notes

      t.boolean :active, null: false, default: true

      t.string :email, null: false
      t.string :login, limit: 30, null: false
      t.string :role, null: false

      t.string :encrypted_password, limit: 40, null: false
      t.string :password_salt, limit: 40, null: false
      t.string :reset_password_token, limit: 40
      t.datetime :reset_password_sent_at

      t.datetime :last_sign_in_at
      t.inet :last_sign_in_ip

      t.string :browser
      t.string :platform

      t.timestamps
    end

    add_index :users, :name, name: 'id_users_name'
    add_index :users, :matriculation, unique: true, name: 'ui_users_matriculation'
    add_index :users, :email, unique: true, name: 'ui_users_email'
    add_index :users, :login, unique: true, name: 'ui_users_login'
    add_index :users, :reset_password_token, unique: true, name: 'ui_users_reset_password_token'
  end
end