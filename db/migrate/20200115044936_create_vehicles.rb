class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :vin, null: false
      t.integer :year
      t.string :make
      t.string :model

      t.timestamps
    end
  end
end
