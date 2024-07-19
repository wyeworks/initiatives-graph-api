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
require "rails_helper"

RSpec.describe Initiative, type: :model do
  it "wires up as an initiative of its source" do
    initiative = create(:initiative)
    expect(initiative.source.initiatives).to include(initiative)
  end

  it "wires up as an initiative of its helpers" do
    initiative = create(:initiative_with_helpers)
    expect(initiative.helpers.first.initiatives).to include(initiative)
  end
end
