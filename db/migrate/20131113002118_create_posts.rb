class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :slug
      t.string :post_type
      t.datetime :publish
      t.hstore :tags

      t.timestamps
    end
  end
end
