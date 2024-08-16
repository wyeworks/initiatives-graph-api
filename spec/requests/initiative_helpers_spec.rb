# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Initiative helpers Endpoint", type: :request do
  let(:initiative) { create(:initiative, :with_helpers) }
  let(:wyeworkers) { [create(:manager), create(:developer)] }

  it "GET /initiatives/:initiative_id/helpers" do
    get initiative_helpers_path(initiative.id)
    expect(response.body).to eq(initiative.helpers.to_json)
  end

  it "POST /initiatives/:initiative_id/helpers" do
    helper_ids = initiative.helpers.map(&:id).concat wyeworkers.map(&:id)

    expect { post initiative_helpers_path(initiative.id), params: helper_ids, as: :json }
      .to change {
            initiative.helpers.count
          }.by 2

    db_helpers = initiative.reload.helpers

    expect(response.body).to eq(db_helpers.to_json)
  end
end
