class AddBovespaUrlToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :bovespa_url, :string
  end
end
