# frozen_string_literal: true

# == Schema Information
#
# Table name: wyeworkers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wyeworkers_on_name  (name) UNIQUE
#
require "rails_helper"

RSpec.describe Wyeworker, type: :model do
  it "wires up properly as a source" do
    source = create(:wyeworker)
    create(:initiative, source:)

    expect(source.wyeworker_initiative_belongings.sample.kind).to eql("source")
  end

  it "wires up properly as a helper" do
    helpers = create_list(:wyeworker, 5)
    create(:initiative, helpers:)

    expect(helpers.sample.wyeworker_initiative_belongings.sample.kind).to eql("helper")
  end
end
