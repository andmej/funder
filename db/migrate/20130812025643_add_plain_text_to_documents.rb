class AddPlainTextToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :plain_text, :text
  end
end
