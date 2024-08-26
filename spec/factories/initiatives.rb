# frozen_string_literal: true

# == Schema Information
#
# Table name: initiatives
#
#  id          :integer          not null, primary key
#  description :string
#  startdate   :date
#  status      :integer
#  title       :string           not null
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :integer          not null
#  parent_id   :integer
#
# Indexes
#
#  index_initiatives_on_owner_id   (owner_id)
#  index_initiatives_on_parent_id  (parent_id)
#  index_initiatives_on_title      (title) UNIQUE
#
# Foreign Keys
#
#  owner_id   (owner_id => wyeworkers.id) ON DELETE => cascade
#  owner_id   (owner_id => wyeworkers.id)
#  parent_id  (parent_id => initiatives.id)
#
FactoryBot.define do
  factory :initiative, aliases: %i[initiative_no_parent] do
    sequence :title do |n|
      "Initiative-#{n}"
    end

    sequence :description do |n|
      "Initiative Description #{n}"
    end

    helpers { build_list(:wyeworker, 3) << build(:manager) }

    status { :in_progress }

    owner { create :manager }

    factory :initiative_no_helpers do
      helpers { [] }
    end

    trait :with_helpers do
      helpers { build_list(:developer, 3) << build(:manager) }
    end

    trait :with_parent do
      parent { build(:initiative) }
    end

    trait :with_helpers_no_manager do
      owner { create :developer }
      helpers { build_list(:developer, 3) }
    end
  end
end
