class MoreSumsVerification < ActiveRecord::Migration
  def change
    add_column :verifications, :recibidas, :integer
    add_column :verifications, :sobrantes, :integer
    add_column :verifications, :ciudadanos, :integer
    add_column :verifications, :miembros_mer, :integer
  end
end
