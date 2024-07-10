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
#
class Iniciativa < ApplicationRecord
end
