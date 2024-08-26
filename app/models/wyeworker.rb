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
class Wyeworker < ApplicationRecord
  has_many :owned_initiatives, foreign_key: :owner_id, class_name: "Initiative", dependent: :destroy
  has_and_belongs_to_many :helped_initiatives, class_name: "Initiative"

  validates :name, presence: true, uniqueness: true
end
