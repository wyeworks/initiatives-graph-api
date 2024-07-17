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
        initiative_no_helpers = build(:initiative_no_helpers)
        expect(initiative_no_helpers).to be_valid

        initiative_with_helper = build(:initiative_with_helpers)
        expect(initiative_with_helper).to be_valid
      end

      it 'must have a source' do
        initiative = build(:initiative, source: nil)
        expect(initiative).to be_invalid
      end

      it 'may have a parent' do
        initiative_no_parent = build(:initiative)
        expect(initiative_no_parent).to be_valid

        initiative_with_parent = build(:initiative_with_parent)
        expect(initiative_with_parent).to be_valid
      end
  end
  
  context 'when looking back from its entities,' do
    it 'is an initiative of its source' do
      initiative = create(:initiative)
      expect(initiative.source.initiatives).to include(initiative)
    end
    it 'is an initiative of its helpers' do
      initiative = create(:initiative_with_helpers)
      expect(initiative.helpers.first.initiatives).to include(initiative)
    end
  end

end
