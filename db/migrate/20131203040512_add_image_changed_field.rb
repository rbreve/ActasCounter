class AddImageChangedField < ActiveRecord::Migration
  def change
    add_column :acta, :image_changed, :boolean, :default=>false
    add_column :verifications, :image_changed, :boolean, :default=>false
  end
end
