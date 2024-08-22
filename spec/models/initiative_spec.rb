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
#  owner_id   :integer          not null
#
# Indexes
#
#  index_initiatives_on_parent_id  (parent_id)
#  index_initiatives_on_owner_id  (owner_id)
#  index_initiatives_on_title      (title) UNIQUE
#
# Foreign Keys
#
#  parent_id  (parent_id => initiatives.id)
#  owner_id  (owner_id => wyeworkers.id)
#

RSpec.describe Initiative, type: :model do
  describe "validations" do
    let(:initiative) { build(:initiative) }

    context "without an associated manager" do
      it "is invalid" do
        initiative.owner = build(:developer)
        initiative.helpers = [build(:developer)]

        initiative.validate
        expect(initiative.errors.full_messages).to include(/manager/)
      end
    end

    context "with an associated manager" do
      describe "as the owner" do
        it "is valid" do
          initiative.owner = build(:manager)
          initiative.helpers = [build(:developer)]
          expect(build(:initiative, owner: build(:manager), helpers: [])).to be_valid
        end
      end

      describe "as a helper" do
        it "is valid" do
          initiative.owner = build(:developer)
          initiative.helpers = build_list(:developer, 3) << build(:manager)
          expect(initiative).to be_valid
        end
      end

      describe "as both a owner and as a helper" do
        it "is valid" do
          initiative.owner = build(:manager)
          initiative.helpers = build_list(:developer, 3) << build(:manager)
          expect(initiative).to be_valid
        end
      end
    end
  end
end
