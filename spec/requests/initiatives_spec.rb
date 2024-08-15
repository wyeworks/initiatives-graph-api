# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Initiatives Endpoint", type: :request do
  let(:initiatives) { create_list(:initiative, 5) }
  let(:initiative) { create(:initiative) }

  let(:developer) { create(:wyeworker) }

  it "GET /initiatives" do
    initiatives
    all_db_initiatives = Initiative.all
    get initiatives_path
    expect(response.body).to eq(all_db_initiatives.to_json(include: {
                                                             helpers: { only: [:id] },
                                                             source: { only: [:id] },
                                                             parent: { only: [:id] }
                                                           }))
  end

  it "GET /initiatives/:initiative_id" do
    initiatives
    get initiative_path(initiative)
    expect(response.body).to eq(initiative.to_json(include: {
                                                     helpers: { only: [:id] },
                                                     source: { only: [:id] },
                                                     parent: { only: [:id] }
                                                   }))
  end

  it "POST /initiatives" do
    initiative = build(:initiative, source: create(:manager), helpers: create_list(:wyeworker, 3))

    post initiatives_path, params: initiative.as_json(include: {
                                                        helpers: { only: [:id] },
                                                        source: { only: [:id] },
                                                        parent: { only: [:id] }
                                                      }), as: :json

    # expect(response).to have_http_status(:created)
    # TODO: eq(initiative.to_json) doesnt work because of the description default value,
    # and the absence of an id before POSTing

    # Use expect db to have changed instead of looking at response
    # And expect lookup by title of newly created object to have the POSTed title
    # Then expect DB object to be the reponse body
    expect(response.body).to include(initiative.title)
  end

  it "PUT /initiatives" do
    different_title = "A different initiative title"
    initiative = create(:initiative)
    initiative.title = different_title

    put initiative_path(initiative), params: initiative.as_json(include: {
                                                                  helpers: { only: [:id] },
                                                                  source: { only: [:id] },
                                                                  parent: { only: [:id] }
                                                                }), as: :json
    expect(response).to have_http_status(:ok)
    # TODO: cannot expect response.body to equal initiative.as_json,
    # because the attributes are coming in in a different order?
    expect(response.body).to include(different_title)
  end

  it "DELETE /initiatives/:initiative_id" do
    delete initiative_path(initiative)
    expect(response).to have_http_status(:no_content)
  end
end
