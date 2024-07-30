# frozen_string_literal: true

RSpec.describe "Initiatives Endpoint", type: :request do
  let!(:initiatives) { create_list(:initiative, 5) }

  let(:initiative_titles) { initiatives.map(&:title) }
  let(:developer) { create(:wyeworker) }

  # index
  it "shows all initiatives" do
    get "/initiatives"
    expect(response.body).to include(*initiative_titles)
  end

  # show
  it "singles out one initiative" do
    get "/initiatives/#{initiatives.first.id}"
    expect(response.body).to include(initiatives[0].description)
  end

  # create
  it "creates an initiative" do
    i = build(:initiative, source: create(:manager), helpers: create_list(:wyeworker, 3))

    post "/initiatives", params: { initiative: i.as_param, source: i.source_param, helpers: i.helpers_param }
    expect(response).to have_http_status(:created)
    expect(response.body).to include(i.title)
  end

  # update
  it "updates an initiative" do
    different_title = "A different initiative title"

    put "/initiatives/#{initiatives.first.id}",
        params: { initiative: { title: different_title } }
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(different_title)
  end

  # destroy
  it "deletes an initiative" do
    delete "/initiatives/#{initiatives.first.id}"
    expect(response).to have_http_status(:no_content)
  end

  # transfer
  it "transfers an initiative" do
    post "/initiatives/#{initiatives.first.id}/transfer/#{developer.id}"
    expect(response).to have_http_status(:no_content)
  end
end
