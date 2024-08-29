# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Managers Endpoint", type: :request do
  let(:manager) { create(:manager) }
  let(:managers) { create_list(:manager, 5) << manager }

  it "GET /managers" do
    managers
    get managers_path, as: :json
    expect(response.parsed_body).to eq(Manager.all.as_json)
  end

  it "GET /managers/:manager_id" do
    get manager_path(manager), as: :json
    expect(response.parsed_body).to eq(manager.as_json)
  end

  it "POST /managers" do
    manager = attributes_for(:manager)

    post managers_path, params: manager, as: :json
    expect(response).to have_http_status(:created)
    expect(response.parsed_body).to include(manager)
  end

  it "PUT /managers" do
    different_name = "A different manager name"

    put manager_path(manager), params: { manager: { name: different_name } }, as: :json
    manager.name = different_name
    expect(manager.reload).to eq(manager)
    expect(response.parsed_body).to eq(manager.as_json)
  end

  it "DELETE /managers/:manager_id" do
    delete manager_path(manager), as: :json
    expect(response).to have_http_status(:no_content)
    expect { manager.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
