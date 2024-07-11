# == Schema Information
#
# Table name: initiatives
#
#  id          :integer          not null, primary key
#  description :string
#  startdate   :date
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  parent_id   :integer
#
# Indexes
#
#  index_initiatives_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  parent_id  (parent_id => initiatives.id)
#
class Initiative < ApplicationRecord
  enum status: { finished: "finished", in_progress: "in_progress" }, validate: true

  has_many :wyeworker_initiative_belongings

  validates :wyeworker_initiative_belongings, length: { minimum: 1 }
end
