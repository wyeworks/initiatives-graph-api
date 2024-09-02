# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Initiative helpers Endpoint", type: :request do
  let(:helper) { create(:developer) }
  let(:helped_initiative) { create(:initiative, helpers: create_list(:developer, 3) << helper) }

  it "GET /initiatives/:initiative_id/helpers" do
    get initiative_helpers_path(helped_initiative.id), as: :json
    expect(response.parsed_body).to eq(helped_initiative.helpers.as_json)
  end

  it "POST /initiatives/:initiative_id/helpers/:helper_id" do
    new_helper_id = create(:developer).id

    expect do
      post initiative_helpers_path(helped_initiative.id), params: {
        initiative: {
          helpers: [new_helper_id]
        }
      }, as: :json
    end
      .to change {
            helped_initiative.helpers.count
          }.by 1

    expect(response).to have_http_status(:created)

    db_helpers = helped_initiative.reload.helpers

    expect(response.parsed_body).to eq(db_helpers.as_json)
  end

  it "DELETE /initiatives/:initiative_id/helpers/:helper_id" do
    helper_id = helper.id

    expect { delete initiative_helper_path(helped_initiative.id, helper_id), as: :json }
      .to change {
            helped_initiative.helpers.count
          }.by(-1)

    expect(response.parsed_body).to eq(helped_initiative.reload.helpers.as_json)
  end
end
