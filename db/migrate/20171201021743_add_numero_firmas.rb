class AddNumeroFirmas < ActiveRecord::Migration
  def change
    add_column :verifications, :firmas, :integer
    add_column :acta, :firmas, :integer
  end
end
