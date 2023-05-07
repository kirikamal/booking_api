class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.string :reservation_code
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string :status
      t.references :guest, foreign_key: true
      t.string :currency
      t.decimal :payout_price, precision: 10, scale: 2
      t.decimal :security_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
