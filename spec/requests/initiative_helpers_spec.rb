# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Initiative helpers Endpoint", type: :request do
  let(:initiative) { create(:initiative, :with_helpers) }
  let(:wyeworkers) { [create(:manager), create(:developer)] }

  it "GET /initiatives/:initiative_id/helpers" do
    get initiative_helpers_path(initiative.id), as: :json
    expect(response.parsed_body).to eq(initiative.helpers.as_json)
  end

  it "POST /initiatives/:initiative_id/helpers/:helper_id" do
    helper_id = create(:developer).id

    expect { post initiative_helpers_path(initiative.id), params: [helper_id], as: :json }
      .to change {
            initiative.helpers.count
          }.by 1

    db_helpers = initiative.reload.helpers

    expect(response.parsed_body).to eq(db_helpers.as_json)
  end

  it "DELETE /initiatives/:initiative_id/helpers/:helper_id" do
    helper_id = initiative.helpers.sample.id

    expect { delete initiative_helper_path(initiative.id, helper_id), as: :json }
      .to change {
            initiative.helpers.count
          }.by(-1)

    expect(response.parsed_body).to eq(initiative.reload.helpers.as_json)
  end
end
