# == Schema Information
#
# Table name: initiatives
#
#  id          :integer          not null, primary key
#  description :string
#  startdate   :date
#  status      :integer
#  title       :string           not null
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
  enum :status, finished: "finished", in_progress: "in_progress"

  has_many :helper_initiative_belongings,
    -> { where(kind: :helper) },
    class_name: 'WyeworkerInitiativeBelonging'
  has_many :helpers,
    ->() { where(wyeworker_initiative_belongings: { kind: :helper }) },
    through: :helper_initiative_belongings,
    :source => :wyeworker

  has_one :source_initiative_belonging,
    -> { where(kind: :source) },
    class_name: 'WyeworkerInitiativeBelonging'
  has_one :source,
    ->() { where(wyeworker_initiative_belongings: { kind: :source }) },
    through: :source_initiative_belonging,
    :source => :wyeworker

  has_one :parent, class_name: 'Initiative', foreign_key: 'parent_id'

  validates :source, presence: true
  validates :title, presence: true
end
