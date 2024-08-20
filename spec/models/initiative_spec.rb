# frozen_string_literal: true

require "rails_helper"

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

# TODO: add test for wyeworker cannot_destroy_if_source
RSpec.describe Initiative, type: :model do
  let(:initiative) { create(:initiative) }
  let(:initiative_with_helpers) { create(:initiative, :with_helpers) }

  it "wires up as an initiative of its source" do
    expect(initiative.source.sourced_initiatives).to include(initiative)
  end

  it "wires up as an initiative of its helpers" do
    expect(initiative_with_helpers.helpers.sample.helped_initiatives).to include(initiative_with_helpers)
  end

  it "is invalid without a manager" do
    initiative_no_manager = build(:initiative, source: build(:developer))
    expect(initiative_no_manager).to be_invalid
  end

  context "with just one manager involved" do
    it "is valid with them being the source" do
      expect(build(:initiative, source: build(:manager), helpers: [])).to be_valid
    end

    it "is valid with them being a helper" do
      expect(build(:initiative, source: build(:developer), helpers: [build(:manager)])).to be_valid
    end
  end

  it "provides a default description" do
    expect(initiative.description).not_to be_empty
  end
end
