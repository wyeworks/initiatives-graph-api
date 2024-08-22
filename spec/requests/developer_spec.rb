# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Developers Endpoint", type: :request do
  let(:developers) { create_list(:developer, 5) }

  it "GET /developers" do
    developers
    get developers_path
    expect(response.parsed_body).to eq(Developer.all.as_json)
  end

  it "GET /developers/:developer_id" do
    developer = developers.sample
    get developer_path(developer)
    expect(response.parsed_body).to eq(developer.as_json)
  end

  it "POST /developers" do
    developer = attributes_for(:developer)

    post developers_path, params: developer, as: :json
    expect(response).to have_http_status(:created)
    expect(response.body).to include(developer[:name])
  end

  it "PUT /developers" do
    developer = create(:developer)
    different_name = "A different developer name"
    developer.name = different_name

    put developer_path(developer), params: developer.as_json, as: :json
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(different_name)
  end

  it "DELETE /developers/:developer_id" do
    developer = developers.sample
    delete developer_path(developer)
    expect(response).to have_http_status(:no_content)
  end
end
