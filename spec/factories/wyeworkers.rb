# frozen_string_literal: true

FactoryBot.define do
  factory :wyeworker do
    sequence :name do |n|
      "Wyeworker-#{n}"
    end

    factory :source do
      after(:create) do |source|
        FactoryBot.create(:initiative, source:)
      end
    end

    factory :helper do
      after(:create) do |helper|
        FactoryBot.create(:initiative, helpers: [helper])
      end
    end
  end
end
