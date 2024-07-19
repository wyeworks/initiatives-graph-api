# frozen_string_literal: true

FactoryBot.define do
  factory :initiative, aliases: %i[initiative_no_helpers initiative_no_parent] do
    title { "Test Initiative" }

    source { build :wyeworker }

    factory :initiative_with_helpers do
      helpers { build_list(:wyeworker, 3) }
    end
    factory :initiative_with_parent do
      parent { build :initiative }
    end
  end
end
