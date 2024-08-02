# frozen_string_literal: true

FactoryBot.define do
  factory :developer do
    sequence :name do |n|
      "Developer-#{n}"
    end
  end
end
