class AddVideoUrlsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :videoUrls, :json, default:[]
  end
end
