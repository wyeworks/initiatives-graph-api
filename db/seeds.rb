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
  Wyeworker.find_or_create_by!(name: wye_name)
end

Manager.find_or_create_by(name: "Jess")
Manager.find_or_create_by(name: "Cholee")

i = Initiative.new(title: "Juntada")
i.source = Wyeworker.find_by(name: "Ana")
i.helpers = Wyeworker.where(name: %w[
                              Jess
                              Juan
                              Edu
                              Facu
                              Bob
                              Pedro
                            ])
i.save!

i = Initiative.new(title: "JuntadaCeramica")
i.parent = Initiative.find_by(title: "Juntada")
i.source = Wyeworker.find_by(name: "Juan")
i.helpers = Wyeworker.where(name: %w[
                              Jess
                              Carlos
                              Dani
                            ])
i.save!

i = Initiative.new(title: "Libreria")
i.source = Wyeworker.find_by(name: "Bob")
i.helpers = Wyeworker.where(name: %w[
                              Pedro
                              Ana
                              Facu
                              Cholee
                            ])
i.save!
