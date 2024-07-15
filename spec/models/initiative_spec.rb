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
require 'rails_helper'

RSpec.describe Initiative, type: :model do
  context 'in its entities,' do
      it 'may have helpers' do
        source = Wyeworker.new(name: "Source Pablo")
        initiative_no_helpers = Initiative.new(title: "Test Inititative No Helpers", source: source)

        expect(initiative_no_helpers).to be_valid

        helper = Wyeworker.new(name: "Helper Pedro")
        initiative_with_helper = Initiative.new(title: "Test Inititative With Helper", source: source, helpers: [helper])

        expect(initiative_with_helper).to be_valid
      end

      it 'must have a source' do
        helper = Wyeworker.new(name: "Helper Pedro")
        initiative = Initiative.new(title: "Test Inititative", helpers: [helper])

        expect(initiative).to be_invalid
      end

      it 'may have a parent' do
        source = Wyeworker.new(name: "Source Pablo")
        initiative_no_parent = Initiative.new(title: "Test Inititative No Parent", source: source)

        expect(initiative_no_parent).to be_valid

        parent = Initiative.new(title: "Test Inititative Parent", source: source)
        initiative_with_parent = Initiative.new(title: "Test Inititative With Parent", source: source, parent: parent)

        expect(initiative_with_parent).to be_valid
      end
  end
  
  context 'when looking back from its entities,' do
    it 'is an initiative of its source' do
      source = Wyeworker.new(name: "Source Pablo")
      initiative = Initiative.create(title: "Test Inititative", source: source)

      expect(source.initiatives).to include(initiative)
    end

    it 'is an initiative of its helpers' do
      source = Wyeworker.new(name: "Source Pablo")
      helper = Wyeworker.new(name: "Helper Pedro")
      initiative = Initiative.create(title: "Test Inititative", source: source, helpers: [helper])

      expect(helper.initiatives).to include(initiative)
    end
  end

end
