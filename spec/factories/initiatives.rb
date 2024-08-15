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
#  parent_id   :integer
#  source_id   :integer          not null
#
# Indexes
#
#  index_initiatives_on_parent_id  (parent_id)
#  index_initiatives_on_source_id  (source_id)
#  index_initiatives_on_title      (title) UNIQUE
#
# Foreign Keys
#
#  parent_id  (parent_id => initiatives.id)
#  source_id  (source_id => wyeworkers.id)
#
FactoryBot.define do
  factory :initiative, aliases: %i[initiative_no_parent] do
    sequence :title do |n|
      "Initiative-#{n}"
    end

    sequence :description do |n|
      "Initiative Description #{n}"
    end

    status { :in_progress }

    source { build :manager }

    trait :with_helpers do
      helpers { build_list(:wyeworker, 3) << build(:manager) }
    end

    trait :with_parent do
      parent { build(:initiative) }
    end

    trait :with_helpers_no_manager do
      source { build :wyeworker }
      helpers { build_list(:wyeworker, 3) }
    end
  end
end
