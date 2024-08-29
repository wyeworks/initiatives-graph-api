# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Developers Endpoint", type: :request do
  let(:developer) { create(:developer) }
  let(:developers) { create_list(:developer, 5) << developer }

  it "GET /developers" do
    developers
    get developers_path, as: :json
    expect(response.parsed_body).to eq(Developer.all.as_json)
  end

  it "GET /developers/:developer_id" do
    get developer_path(developer), as: :json
    expect(response.parsed_body).to eq(developer.as_json)
  end

  it "POST /developers" do
    developer = attributes_for(:developer)

    post developers_path, params: developer, as: :json
    expect(response).to have_http_status(:created)
    expect(response.parsed_body).to include(developer)
  end

  it "PUT /developers" do
    different_name = "A different developer name"
    developer.name = different_name

    put developer_path(developer), params: { developer: { name: different_name } }, as: :json
    expect(developer.reload.name).to eq(different_name)
    expect(response.parsed_body).to eq(developer.as_json)
  end

  it "DELETE /developers/:developer_id" do
    delete developer_path(developer), as: :json
    expect(response).to have_http_status(:no_content)
    expect { developer.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
