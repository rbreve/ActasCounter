class UpdateParties < ActiveRecord::Migration
  def change
    # remove old parties
    remove_column :acta, :libre, :alianza, :faper, :pinu

    # add new parties
    add_column :acta, :libre_pinu, :integer
    add_column :acta, :frente_amplio, :integer
    add_column :acta, :alianza_patriotica, :integer
    add_column :acta, :vamos, :integer

    # update indices
    (remove_index "acta", name: "acta_counts_index") rescue nil
    add_index "acta", ["liberal", "nacional", "libre_pinu", "pac", "ud", "dc", "alianza_patriotica", "blancos", "nulos", "frente_amplio", "vamos"], :name => "acta_counts_index"

    # Verifications
    remove_column :verifications, :libre, :alianza, :faper, :pinu
    add_column :verifications, :libre_pinu, :integer
    add_column :verifications, :frente_amplio, :integer
    add_column :verifications, :alianza_patriotica, :integer
    add_column :verifications, :vamos, :integer
  end
end
