class AddAncestryToHierarchyNodes < ActiveRecord::Migration[5.0]
  def change
    add_column :hierarchy_nodes, :ancestry, :uuid
  end
end
