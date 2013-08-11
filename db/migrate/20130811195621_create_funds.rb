class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.string :trading_name
      t.string :corporate_name

      t.timestamps
    end
  end
end
