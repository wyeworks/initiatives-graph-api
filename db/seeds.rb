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

Manager.find_or_create_by!(name: "Jess")
Manager.find_or_create_by!(name: "Cholee")

Initiative.create!(
  title: "Juntada",
  owner: Developer.find_by(name: "Ana"),
  helpers: Wyeworker.where(name: %w[
                             Jess
                             Juan
                             Edu
                             Facu
                             Bob
                             Pedro
                           ])
)

Initiative.create!(
  title: "JuntadaCeramica",
  parent: Initiative.find_by(title: "Juntada"),
  owner: Developer.find_by(name: "Juan"),
  helpers: Wyeworker.where(name: %w[
                             Jess
                             Carlos
                             Dani
                           ])
)

Initiative.create!(
  title: "Libreria",
  owner: Developer.find_by(name: "Bob"),
  helpers: Wyeworker.where(name: %w[
                             Pedro
                             Ana
                             Facu
                             Cholee
                           ])
)
