require 'csv'

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

brands = {}
items = []
CSV.foreach("#{Rails.root}/db/seed_data/items.csv", :headers => true) do |row|
  brand = brands[row['brand'].titleize]
  unless brand
    brand = Brand.new(id: SecureRandom.uuid, name: row['brand'].titleize)
    brands[row['brand'].titleize] = brand
  end

  items <<  Item.new(id: SecureRandom.uuid, upc: row['upc'], name: row['name'].titleize, uom: row['uom'] || 'EA', brand_id: brand.id)
end

brands.values.each_slice(1000) do |slice|
  puts "Importing batch of #{slice.length} brands"
  Brand.import slice, validate: false
end

items.each_slice(5000) do |slice|
  puts "Importing batch of #{slice.length} items"
  Item.import slice, validate: false
end

items = nil
brands = nil

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
