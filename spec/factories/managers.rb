# frozen_string_literal: true

# == Schema Information
#
# Table name: wyeworkers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wyeworkers_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :manager do
    sequence :name do |n|
      "Manager-#{n}"
    end
  end
end
