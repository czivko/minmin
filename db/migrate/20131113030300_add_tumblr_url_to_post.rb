class AddTumblrUrlToPost < ActiveRecord::Migration
  def change
    add_column :posts, :tumblr_url, :string
  end
end
