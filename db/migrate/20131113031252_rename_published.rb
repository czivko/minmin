class RenamePublished < ActiveRecord::Migration
  def change
    rename_column :posts, :publish, :published_at
  end
end
