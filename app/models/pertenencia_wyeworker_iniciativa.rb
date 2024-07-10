# == Schema Information
#
# Table name: pertenencia_wyeworker_iniciativas
#
#  id            :integer          not null, primary key
#  tipo          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  iniciativa_id :integer          not null
#  wyeworker_id  :integer          not null
#
# Indexes
#
#  index_pertenencia_wyeworker_iniciativas_on_iniciativa_id  (iniciativa_id)
#  index_pertenencia_wyeworker_iniciativas_on_wyeworker_id   (wyeworker_id)
#
# Foreign Keys
#
#  iniciativa_id  (iniciativa_id => iniciativas.id)
#  wyeworker_id   (wyeworker_id => wyeworkers.id)
#
class PertenenciaWyeworkerIniciativa < ApplicationRecord
  belongs_to :iniciativa
  belongs_to :wyeworker
end
