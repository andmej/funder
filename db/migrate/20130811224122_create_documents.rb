class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.datetime :published_at
      t.integer :asset_id
      t.string :asset_type
      t.string :category
      t.string :original_url

      t.timestamps
    end
  end
end
