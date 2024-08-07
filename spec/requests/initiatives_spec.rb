# frozen_string_literal: true

RSpec.describe "Initiatives Endpoint", type: :request do
  let!(:initiatives) { create_list(:initiative, 5) }

  let(:initiative_titles) { initiatives.map(&:title) }
  let(:developer) { create(:wyeworker) }

  it "GET /initiatives" do
    get "/initiatives"
    expect(response.body).to include(*initiative_titles)
  end

  it "GET /initiatives/:initiative_id" do
    get "/initiatives/#{initiatives.first.id}"
    expect(response.body).to include(initiatives.first.description)
  end

  it "POST /initiatives" do
    initiative = build(:initiative, source: create(:manager), helpers: create_list(:wyeworker, 3))

    post "/initiatives", params: initiative.as_json
    expect(response).to have_http_status(:created)
    expect(response.body).to include(initiative.title)
  end

  it "PUT /initiatives" do
    different_title = "A different initiative title"
    initiative = create(:initiative)
    initiative.title = different_title

    put "/initiatives/#{initiatives.first.id}", params: initiative.as_json
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(different_title)
  end

  it "DELETE /initiatives/:initiative_id" do
    delete "/initiatives/#{initiatives.first.id}"
    expect(response).to have_http_status(:no_content)
  end
end
