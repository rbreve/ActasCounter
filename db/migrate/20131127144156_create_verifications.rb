class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.integer :liberal
      t.integer :nacional
      t.integer :libre
      t.integer :pac
      t.integer :ud
      t.integer :dc
      t.integer :alianza
      t.integer :pinu
      t.integer :nulos
      t.integer :blancos
      t.boolean :is_valid
      t.references :acta
      t.references :user
      t.timestamps
    end
  end
end
