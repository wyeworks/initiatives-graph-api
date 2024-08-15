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
#  parent_id   :integer
#  source_id   :integer          not null
#
# Indexes
#
#  index_initiatives_on_parent_id  (parent_id)
#  index_initiatives_on_source_id  (source_id)
#  index_initiatives_on_title      (title) UNIQUE
#
# Foreign Keys
#
#  parent_id  (parent_id => initiatives.id)
#  source_id  (source_id => wyeworkers.id)
#
class Initiative < ApplicationRecord
  enum :status, finished: "finished", in_progress: "in_progress"

  has_and_belongs_to_many :helpers,
                          association_foreign_key: :helper_id,
                          join_table: :initiative_helpers,
                          class_name: "Wyeworker"

  belongs_to :source, dependent: :destroy, class_name: "Wyeworker"

  has_one :parent, class_name: "Initiative", foreign_key: "parent_id"

  validates :source, presence: true
  validates :title, presence: true, uniqueness: true
  validate :must_have_manager

  before_create do
    self.description ||= "No description"
  end

  def must_have_manager
    if !(
        source.is_a?(Manager) ||
        helpers.any? { |h| h.is_a?(Manager) }
      )
      errors.add :wyeworker_initiative_belongings,
                 "An initiative must have a manager involved, as a source or as a helper"
    end
  end
end
