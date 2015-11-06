class AddActumTypeToActum < ActiveRecord::Migration
  def change
    add_column :acta, :actum_type, :string, default: "p"
  end
end
