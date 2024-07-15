# == Schema Information
#
# Table name: wyeworkers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Wyeworker < ApplicationRecord
  has_many :wyeworker_initiative_belongings
  has_many :initiatives, through: :wyeworker_initiative_belongings

  validates :name, presence: true
end
