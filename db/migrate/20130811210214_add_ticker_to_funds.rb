class AddTickerToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :ticker, :string
  end
end
