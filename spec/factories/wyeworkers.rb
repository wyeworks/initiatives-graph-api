# frozen_string_literal: true

# == Schema Information
#
# Table name: wyeworkers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wyeworkers_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :wyeworker do
    sequence :name do |n|
      "Wyeworker-#{n}"
    end

    factory :wyeworker_source do
      after(:create) do |source|
        FactoryBot.create(:initiative, source:)
      end
    end

    factory :wyeworker_helper do
      after(:create) do |helper|
        FactoryBot.create(:initiative, helpers: [helper])
      end
    end
  end
end
