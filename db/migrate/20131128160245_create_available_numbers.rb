class CreateAvailableNumbers < ActiveRecord::Migration
  def change
    create_table :available_numbers do |t|
      t.string :numero
      t.boolean :has_valid_image, :default=>true
      t.boolean :already_assigned, :default=>false
      t.timestamps
    end
  end
end
