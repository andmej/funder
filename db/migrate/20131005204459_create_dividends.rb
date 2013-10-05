class CreateDividends < ActiveRecord::Migration
  def change
    create_table :dividends do |t|
      t.decimal :amount
      t.date :last_day
      t.integer :fund_id
      t.integer :document_id

      t.timestamps
    end
  end
end
