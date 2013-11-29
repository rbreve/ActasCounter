class CreateReportes < ActiveRecord::Migration
  def change
    create_table :reportes do |t|
      t.text :body
      t.integer :user_id
      t.integer :acta_id
      t.datetime :date

      t.timestamps
    end
  end
end
