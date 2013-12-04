class CreateDepartamentos < ActiveRecord::Migration
  def change
    create_table :departamentos do |t|
      t.string  :name
      t.integer :num
      t.integer :from_actum
      t.integer :to_actum
      t.timestamps
    end
  end
end
