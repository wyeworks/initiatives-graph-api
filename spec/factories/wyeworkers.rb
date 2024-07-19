# frozen_string_literal: true

FactoryBot.define do
  factory :wyeworker do
    name { "Test Wyeworker " }

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

    factory :manager
  end
end
