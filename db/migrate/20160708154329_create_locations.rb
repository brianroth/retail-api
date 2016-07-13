class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations, id: :uuid  do |t|
      t.integer :external_id, index: true, null: false
      t.string :name, null: false
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :postal_code

      t.timestamps
    end
  end
end
