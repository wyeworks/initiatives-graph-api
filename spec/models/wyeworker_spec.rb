# frozen_string_literal: true

# == Schema Information
#
# Table name: wyeworkers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Wyeworker, type: :model do
  context "in its initiatives" do
    it "can correctly take up the role of a source" do
      source = create(:source)

      expect(source.wyeworker_initiative_belongings.first.kind).to eql("source")
    end

    it "can correctly take up the role of a helper" do
      helper = create(:helper)

      expect(helper.wyeworker_initiative_belongings.first.kind).to eql("helper")
    end
  end
end
