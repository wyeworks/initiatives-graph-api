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
          }.by wyeworkers.length

    db_helpers = initiative.reload.helpers

    expect(response.body).to eq(db_helpers.to_json)
  end

  it "PUT /initiatives/:initiative_id/helpers/:helper_id" do
    helper_id = create(:developer).id

    expect { put initiative_helper_path(initiative.id, helper_id), params: [helper_id], as: :json }
      .to change {
            initiative.helpers.count
          }.by 1

    db_helpers = initiative.reload.helpers

    expect(response.body).to eq(db_helpers.to_json)
  end

  it "DELETE /initiatives/:initiative_id/helpers/:helper_id" do
    helper_id = initiative.helpers.sample.id

    expect { delete initiative_helper_path(initiative.id, helper_id) }
      .to change {
            initiative.helpers.count
          }.by(-1)

    expect(response).to have_http_status(:no_content)
  end
end
