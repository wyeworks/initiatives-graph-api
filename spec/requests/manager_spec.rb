# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Managers Endpoint", type: :request do
  let(:managers) { create_list(:manager, 5) }

  it "GET /managers" do
    managers
    get managers_path, as: :json
    expect(response.parsed_body).to eq(Manager.all.as_json)
  end

  it "GET /managers/:manager_id" do
    manager = managers.sample
    get manager_path(manager), as: :json
    expect(response.parsed_body).to eq(manager.as_json)
  end

  it "POST /managers" do
    manager = attributes_for(:manager)

    post managers_path, params: manager, as: :json
    expect(response).to have_http_status(:created)
    expect(response.body).to include(manager[:name])
  end

  it "PUT /managers" do
    manager = create(:manager)
    different_name = "A different manager name"
    manager.name = different_name

    put manager_path(manager), params: manager.as_json, as: :json
    expect(response).to have_http_status(:ok)
    expect(response.parsed_body.except("updated_at")).to eq(manager.as_json.except("updated_at"))
  end

  it "DELETE /managers/:manager_id" do
    manager = managers.sample
    delete manager_path(manager), as: :json
    expect(response).to have_http_status(:no_content)
  end
end
