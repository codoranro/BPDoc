class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.date :date_from
      t.date :date_to
      t.string :note
      t.references :user
      t.references :role

      t.timestamps
    end
    add_index :user_roles, :user_id
    add_index :user_roles, :role_id
  end
end
