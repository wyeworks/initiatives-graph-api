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

require "rails_helper"

RSpec.describe Developer, type: :model do
  let(:developer) { create(:developer) }

  it "cannot be deleted if owner of an initiative" do
    # Need the manager here because of an initiative validation
    create(:initiative, owner: developer, helpers: create_list(:manager, 1))
    expect { developer.destroy! }.to raise_error(ActiveRecord::RecordNotDestroyed)
  end
end
