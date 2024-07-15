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
#  initiative_id  (initiative_id => initiatives.id)
#  wyeworker_id   (wyeworker_id => wyeworkers.id)
#
class WyeworkerInitiativeBelonging < ApplicationRecord
  enum :kind, source: "source", helper: "helper"
  belongs_to :initiative
  belongs_to :wyeworker
end
