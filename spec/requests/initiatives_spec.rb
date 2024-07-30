# frozen_string_literal: true

RSpec.describe "Initiatives Endpoint", type: :request do
  let!(:initiatives) { create_list(:initiative, 5) }

  let(:initiative_titles) { initiatives.map(&:title) }

  # index
  it "shows all initiatives" do
    get "/initiatives"
    expect(response.body).to include(*initiative_titles)
  end

  # show
  it "singles out one initiative" do
    get "/initiatives/#{initiatives[0].id}"
    expect(response.body).to include(initiatives[0].description)
  end

  # create
  it "creates an initiative" do
    i = build(:initiative, source: create(:manager), helpers: create_list(:wyeworker, 3))

    headers = { "ACCEPT" => "application/json" }
    post("/initiatives", params: { initiative: i.as_param, source: i.source_param, helpers: i.helpers_param }, headers:)
    expect(response).to have_http_status(:created)
    expect(response.body).to include(i.title)
  end

  # update

  # destroy
end
