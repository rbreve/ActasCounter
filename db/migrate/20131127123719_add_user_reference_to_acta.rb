class AddUserReferenceToActa < ActiveRecord::Migration
  def change
    add_column :acta, :user_id, :integer
  end
end
