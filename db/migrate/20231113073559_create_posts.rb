class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :location
      t.text :tags, default: ''
      t.string :post_picture

      t.timestamps
    end
  end
end
