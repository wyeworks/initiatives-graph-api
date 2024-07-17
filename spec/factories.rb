
FactoryBot.define do

  factory :initiative, aliases: [:initiative_no_helpers, :initiative_no_parent] do
    title { "Test Initiative" }

    source { build :wyeworker }

    factory :initiative_with_helpers do
      helpers { build_list(:wyeworker, 3) }
    end
    factory :initiative_with_parent do
      parent { build :initiative }
    end

  end

  factory :wyeworker do
    name { "Test Wyeworker "}

    factory :source do |s|
      after(:create) do |source|
        FactoryBot.create(:initiative, source:)
      end
    end

    factory :helper do |s|
      after(:create) do |helper|
        FactoryBot.create(:initiative, helpers: [helper])
      end
    end

    factory :manager
  end
end