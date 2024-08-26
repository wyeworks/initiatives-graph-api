# frozen_string_literal: true

# == Schema Information
#
# Table name: initiatives
#
#  id          :integer          not null, primary key
#  description :string
#  startdate   :date
#  status      :integer
#  title       :string           not null
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :integer          not null
#  parent_id   :integer
#
# Indexes
#
#  index_initiatives_on_owner_id   (owner_id)
#  index_initiatives_on_parent_id  (parent_id)
#  index_initiatives_on_title      (title) UNIQUE
#
# Foreign Keys
#
#  owner_id   (owner_id => wyeworkers.id) ON DELETE => cascade
#  owner_id   (owner_id => wyeworkers.id)
#  parent_id  (parent_id => initiatives.id)
#
class Initiative < ApplicationRecord
  enum :status, finished: "finished", in_progress: "in_progress"

  has_and_belongs_to_many :helpers, class_name: "Wyeworker"

  belongs_to :owner, dependent: :destroy, class_name: "Wyeworker"

  has_one :parent, class_name: "Initiative", foreign_key: "parent_id", dependent: :destroy

  validates :owner, presence: true
  validates :title, presence: true, uniqueness: true
  validate :must_have_manager

  def must_have_manager
    if !(
      owner.is_a?(Manager) ||
        helpers.any? { |h| h.is_a?(Manager) }
    )
      errors.add !owner.is_a?(Manager) ? :source : :helpers,
                 "An initiative must have a manager involved, as a source or as a helper"
    end
  end
end
