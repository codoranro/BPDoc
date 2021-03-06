class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :shortname
      t.string :name
      t.text :description
      t.text :note
      t.text :source

      t.timestamps
    end
    add_index :terms, :shortname, :unique => true
    add_index :terms, :name, :unique => true
  end
end
