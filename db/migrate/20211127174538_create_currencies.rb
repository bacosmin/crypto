class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :symbol
      t.string :currency_id
      t.string :multiplication_factor
      t.string :transaction_cost
      t.string :multisig_transaction_cost
      t.string :formula

      t.timestamps
    end
  end
end
