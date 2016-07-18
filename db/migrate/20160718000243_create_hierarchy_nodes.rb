class CreateHierarchyNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :hierarchy_nodes, id: :uuid  do |t|
      t.integer :external_id, index: true, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
