# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

%w[Ana Pedro Carlos Dani Juan Edu Facu Bob].each do |wye_name|
  Developer.find_or_create_by!(name: wye_name)
end

Manager.find_or_create_by(name: "Jess")
Manager.find_or_create_by(name: "Cholee")

i = Initiative.new(title: "Juntada")
i.source = Developer.find_by(name: "Ana")
i.helpers = [
  Manager.find_by(name: "Jess"),
  Developer.find_by(name: "Juan"),
  Developer.find_by(name: "Edu"),
  Developer.find_by(name: "Facu"),
  Developer.find_by(name: "Bob"),
  Developer.find_by(name: "Pedro")
]
i.save!

i = Initiative.new(title: "JuntadaCeramica")
i.parent = Initiative.find_by(title: "Juntada")
i.source = Developer.find_by(name: "Juan")
i.helpers = [
  Manager.find_by(name: "Jess"),
  Developer.find_by(name: "Carlos"),
  Developer.find_by(name: "Dani")
]
i.save!

i = Initiative.new(title: "Libreria")
i.source = Developer.find_by(name: "Bob")
i.helpers = [
  Developer.find_by(name: "Pedro"),
  Developer.find_by(name: "Ana"),
  Developer.find_by(name: "Facu"),
  Manager.find_by(name: "Cholee")
]
i.save!
