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

RSpec.describe Initiative, type: :model do
  let(:initiative) { create(:initiative) }

  it "provides a default description" do
    expect(initiative.description).not_to be_empty
  end

  context "when validating the presence of a manager" do
    let(:initiative) { build(:initiative) }

    it "is invalid without a manager" do
      initiative.source = build(:developer)
      initiative.helpers = [build(:developer)]

      initiative.validate
      expect(initiative.errors.full_messages).to include(/manager/)
    end

    it "is valid with a manager being only the source" do
      initiative.source = build(:manager)
      initiative.helpers = [build(:developer)]
      expect(build(:initiative, source: build(:manager), helpers: [])).to be_valid
    end

    it "is valid with a manager being only one helper" do
      initiative.source = build(:developer)
      initiative.helpers = build_list(:developer, 3) << build(:manager)
      expect(initiative).to be_valid
    end
  end
end
