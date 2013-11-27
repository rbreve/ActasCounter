class AddReadyForReviewBoolean < ActiveRecord::Migration
  def change
    add_column :acta, :ready_for_review, :boolean, :default=>true
  end
end
