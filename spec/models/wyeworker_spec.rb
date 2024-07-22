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
    source = create(:wyeworker_source)

    expect(source.wyeworker_initiative_belongings.first.kind).to eql("source")
  end

  it "wires up properly as a helper" do
    helper = create(:wyeworker_helper)

    expect(helper.wyeworker_initiative_belongings.first.kind).to eql("helper")
  end
end
