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
  has_many :sourced_initiatives,
           foreign_key: :source_id,
           class_name: "Initiative"
  has_and_belongs_to_many :helped_initiatives,
                          join_table: :initiative_helpers,
                          foreign_key: :helper_id,
                          class_name: "Initiative"

  validates :name, presence: true, uniqueness: true

  def as_json(...)
    json = super(...)
    json[:sourced_initiatives] = sourced_initiatives.map(&:id)
    json[:helped_initiatives] = helped_initiatives.map(&:id)
    { self.class.name.downcase => json }
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
