# frozen_string_literal: true

FactoryBot.define do
  factory :manager do
    sequence :name do |n|
      "Manager-#{n}"
    end
  end
end
