# frozen_string_literal: true

FactoryBot.define do
  factory :initiative, aliases: %i[initiative_no_parent] do
    sequence :title do |n|
      "Initiative-#{n}"
    end

    source { build :manager }

    helpers { build_list(:wyeworker, 3) }

    before(:create) do |initiative|
      initiative.helpers << build(:manager)
    end

    factory :initiative_no_helpers do
      helpers { [] }
    end

    factory :initiative_with_parent do
      parent { build :initiative }
    end

    factory :initiative_no_manager do
      source { build :wyeworker }
      before(:create) do |initiative|
        initiative.helpers = build_list(:wyeworker, 3)
      end
    end
  end
end
