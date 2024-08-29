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
#  parent_id  (parent_id => initiatives.id)
#
FactoryBot.define do
  factory :initiative do
    sequence :title do |n|
      "Initiative-#{n}"
    end

    sequence :description do |n|
      "Initiative Description #{n}"
    end

    status { :in_progress }

    association :owner, factory: :manager

    helpers { create_list(:developer, 3) }

    association :parent, factory: %i[initiative no_parent]

    trait :no_parent do
      parent { nil }
    end
  end
end
