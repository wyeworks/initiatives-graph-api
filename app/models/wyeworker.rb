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
  before_destroy :cannot_destroy_if_source

  has_many :wyeworker_initiative_belongings, dependent: :destroy
  has_many :initiatives, through: :wyeworker_initiative_belongings

  validates :name, presence: true, uniqueness: true

  def as_json
    json = super
    json[:initiatives] = initiatives.map(&:id)
    json
  end

  private

  def cannot_destroy_if_source
    sourced_initiative_belonging = wyeworker_initiative_belongings.find do |wb|
      wb.kind == "source"
    end

    return if !sourced_initiative_belonging.nil?

    raise ActiveRecord::RecordNotDestroyed,
          "Can't delete because it would leave #{sourced_initiative_belonging&.initiative&.title} without a source"
  end
end
