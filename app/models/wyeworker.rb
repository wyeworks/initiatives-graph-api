# == Schema Information
#
# Table name: wyeworkers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Wyeworker < ApplicationRecord
  has_many :pertenencia_wyeworker_iniciativas
end
