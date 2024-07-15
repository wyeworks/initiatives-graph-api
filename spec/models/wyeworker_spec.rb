# == Schema Information
#
# Table name: wyeworkers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Wyeworker, type: :model do
  context 'in its initiatives' do
    it 'can correctly take up the role of a source' do
      source = Wyeworker.new(name: "Source Pablo")
      helper = Wyeworker.new(name: "Helper Pedro", )
      initiative = Initiative.create(title: "Test Inititative", source: source, helpers: [helper])

      expect(source.wyeworker_initiative_belongings.first.kind).to eql("source")
      expect(initiative.source).to be(source)
    end

    it 'can correctly take up the role of a helper' do
      source = Wyeworker.new(name: "Source Pablo")
      helper = Wyeworker.new(name: "Helper Pedro", )
      initiative = Initiative.create(title: "Test Inititative", source: source, helpers: [helper])

      expect(helper.wyeworker_initiative_belongings.first.kind).to eql("helper")
      expect(initiative.helpers.first).to be(helper)
    end
  end
end
