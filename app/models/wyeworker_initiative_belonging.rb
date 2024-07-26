# frozen_string_literal: true

# == Schema Information
#
# Table name: wyeworker_initiative_belongings
#
#  kind          :string
#  initiative_id :integer          not null, primary key
#  wyeworker_id  :integer          not null, primary key
#
# Indexes
#
#  index_wyeworker_initiative_belongings_on_initiative_id  (initiative_id)
#  index_wyeworker_initiative_belongings_on_wyeworker_id   (wyeworker_id)
#
# Foreign Keys
#
#  initiative_id  (initiative_id => initiatives.id) ON DELETE => cascade
#  wyeworker_id   (wyeworker_id => wyeworkers.id) ON DELETE => cascade
#
class WyeworkerInitiativeBelonging < ApplicationRecord
  enum :kind, source: "source", helper: "helper"
  belongs_to :initiative
  belongs_to :wyeworker

  def kind=(_)
    raise USE_TRANSFER_INITIATIVE_MESSAGE unless caller[0].include?("activemodel")

    super
  end

  def initiative=(_)
    raise USE_TRANSFER_INITIATIVE_MESSAGE unless caller[0].include?("activemodel")

    super
  end

  def wyeworker=(_)
    raise USE_TRANSFER_INITIATIVE_MESSAGE unless caller[0].include?("activemodel")

    super
  end
end
