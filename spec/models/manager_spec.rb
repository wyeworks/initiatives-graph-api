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

RSpec.describe Manager, type: :model do
  let(:manager) { create(:manager) }

  it "cannot be deleted if source of an initiative" do
    create(:initiative, source: manager)
    expect { manager.destroy! }.to raise_error(ActiveRecord::RecordNotDestroyed)
  end
end
