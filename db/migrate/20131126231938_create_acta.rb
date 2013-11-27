class CreateActa < ActiveRecord::Migration
  def change
    create_table :acta do |t|
      t.string :numero
      t.integer :liberal
      t.integer :nacional
      t.integer :libre
      t.integer :pac
      t.integer :ud
      t.integer :dc
      t.integer :alianza
      t.integer :pinu
      t.integer :verified

      t.timestamps
    end
  end
end
