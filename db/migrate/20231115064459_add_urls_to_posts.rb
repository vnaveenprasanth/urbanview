class AddUrlsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :imageUrls, :json, default:[]
  end
end
