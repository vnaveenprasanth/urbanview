class AddUseridToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :user_id, :int
  end
end
