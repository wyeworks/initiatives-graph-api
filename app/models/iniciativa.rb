# == Schema Information
#
# Table name: iniciativas
#
#  id          :integer          not null, primary key
#  descripcion :string
#  fechaInicio :date
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  padre_id    :integer
#
# Indexes
#
#  index_iniciativas_on_padre_id  (padre_id)
#
# Foreign Keys
#
#  padre_id  (padre_id => iniciativas.id)
#
class Iniciativa < ApplicationRecord
  enum status: [ :terminada, :en_progreso ]
end
