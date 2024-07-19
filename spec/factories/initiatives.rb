# frozen_string_literal: true

FactoryBot.define do
  factory :initiative, aliases: %i[initiative_no_parent] do
    sequence :title do |n|
      "Initiative-#{n}"
    end

    source { build :manager }

    before(:create) do |initiative|
      initiative.helpers << build(:manager)
    end

    factory :initiative_with_helpers do
      helpers { build_list(:wyeworker, 3) }
    end
    factory :initiative_no_helpers do
      helpers { [] }
    end
    factory :initiative_with_parent do
      parent { build :initiative }
    end
  end
end
