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
#
# Indexes
#
#  index_initiatives_on_parent_id  (parent_id)
#  index_initiatives_on_title      (title) UNIQUE
#
# Foreign Keys
#
#  parent_id  (parent_id => initiatives.id)
#
class Initiative < ApplicationRecord
  include RestJsonUtils
  enum :status, finished: "finished", in_progress: "in_progress"

  has_many :helper_initiative_belongings,
           -> { where(kind: :helper) },
           class_name: "WyeworkerInitiativeBelonging",
           dependent: :destroy
  has_many :helpers,
           -> { where(wyeworker_initiative_belongings: { kind: :helper }) },
           through: :helper_initiative_belongings,
           source: :wyeworker

  has_one :source_initiative_belonging,
          -> { where(kind: :source) },
          class_name: "WyeworkerInitiativeBelonging",
          dependent: :destroy
  has_one :source,
          -> { where(wyeworker_initiative_belongings: { kind: :source }) },
          through: :source_initiative_belonging,
          source: :wyeworker

  has_one :parent, class_name: "Initiative", foreign_key: "parent_id"

  validates :source, presence: true
  validates :title, presence: true, uniqueness: true
  validate :must_have_manager

  before_create do
    self.description ||= "No description"
  end

  def source_param
    wyeworker_to_url(source)
  end

  def helpers_param
    helpers.map { |h| wyeworker_to_url(h) }
  end

  def as_param
    {
      title:,
      description:,
      startdate:,
      parent_id:
    }
  end

  def source=(_)
    raise USE_TRANSFER_INITIATIVE_MESSAGE unless caller[0].match(/transfer_to|activemodel/)

    super
  end

  def transfer_to(new_source)
    self.source = new_source
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
