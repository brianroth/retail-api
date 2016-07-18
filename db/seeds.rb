require 'csv'

# ----------------- Users -----------------
puts "Importing Users"
users = []
CSV.foreach("#{Rails.root}/db/seed_data/users.csv", :headers => true) do |row|
  users <<  User.new(id: SecureRandom.uuid, 
    name: row['name'], 
    email: row['email'],
    password: row['password'],
    active: row['active'])
end
users.each_slice(1000) do |slice|
  puts "Importing batch of #{slice.length} users"
  User.import slice, validate: false
end

# ----------------- Merchandise Hierarchy -----------------
puts "Importing Merchandise Hierarchy"
nodes = {}
CSV.foreach("#{Rails.root}/db/seed_data/merch_hierarchy.csv", :headers => true) do |row|
  unless nodes[row['subcategory_id']]
    nodes[row['subcategory_id'].to_i] = HierarchyNode.new(id: SecureRandom.uuid, external_id: row['subcategory_id'], name: row['subcategory_name'])
  end
end

# ----------------- Brand and Items -----------------
puts "Importing Brand and Items"
brands = {}
items = []
CSV.foreach("#{Rails.root}/db/seed_data/items.csv", :headers => true) do |row|
  brand = brands[row['brand'].titleize]
  unless brand
    brand = Brand.new(id: SecureRandom.uuid, name: row['brand'].titleize)
    brands[row['brand'].titleize] = brand
  end
  node = nodes[row['subcategory'].to_i]

  if node
    items <<  Item.new(id: SecureRandom.uuid, upc: row['upc'], name: row['name'].titleize, uom: row['uom'] || 'EA', brand_id: brand.id, hierarchy_node: node)    
  else
    puts "Unable to locate node with external_id #{row['subcategory']} for upc #{row['upc']}"
  end
end

nodes.values.each_slice(1000) do |slice|
  puts "Importing batch of #{slice.length} nodes"
  HierarchyNode.import slice, validate: false
end

brands.values.each_slice(1000) do |slice|
  puts "Importing batch of #{slice.length} brands"
  Brand.import slice, validate: false
end

items.each_slice(5000) do |slice|
  puts "Importing batch of #{slice.length} items"
  Item.import slice, validate: false
end

# ----------------- Locations -----------------
puts "Importing Locations"
locations = []
CSV.foreach("#{Rails.root}/db/seed_data/locations.csv", :headers => true) do |row|
  locations <<  Location.new(id: SecureRandom.uuid, 
    external_id: row['id'], 
    name: row['name'].titleize, 
    address1: row['address1'],
    address2: row['address2'],
    city: row['city'],
    state: row['state'],
    postal_code: row['postal_code'])
end

locations.each_slice(5000) do |slice|
  puts "Importing batch of #{slice.length} locations"
  Location.import slice, validate: false
end
