class CreateInteractions < ActiveRecord::Migration[7.1]
  def change
    create_table :interactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :option

      t.timestamps
    end
  end
end
