class AddAttributesToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :enable_event, :boolean
    add_column :posts, :start_date, :datetime
    add_column :posts, :end_date, :datetime
  end
end
