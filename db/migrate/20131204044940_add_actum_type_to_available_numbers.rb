class AddActumTypeToAvailableNumbers < ActiveRecord::Migration
  def change
    add_column :available_numbers, :actum_type, :string, :default=>"p"
  end
end
