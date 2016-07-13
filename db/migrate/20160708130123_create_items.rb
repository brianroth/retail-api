class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items, id: :uuid  do |t|
      t.integer :upc, index: true, null: false, limit: 8
      t.string :name, null: false
      t.string :uom, null: false
      t.uuid :brand_id, index: true, null: false
      t.timestamps
    end
  end
end
