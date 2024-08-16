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
                                                             source: { only: [:id] },
                                                             parent: { only: [:id] }
                                                           }))
  end

  it "GET /initiatives/:initiative_id" do
    initiatives
    get initiative_path(initiative)
    expect(response.body).to eq(initiative.to_json(include: {
                                                     source: { only: [:id] },
                                                     parent: { only: [:id] }
                                                   }))
  end

  it "POST /initiatives" do
    initiative = build(:initiative, source: create(:manager), helpers: create_list(:wyeworker, 3))

    include = {
      source: { only: [:id] },
      parent: { only: [:id] }
    }

    expect { post initiatives_path, params: initiative.as_json(include:), as: :json }
      .to change {
            Initiative.all.count
          }.by 1

    db_initiative = Initiative.find_by(title: initiative.title)
    expect(db_initiative).not_to be_nil

    expect(response.body).to eq(db_initiative.to_json(include:))
  end

  it "PUT /initiatives" do
    different_title = "A different initiative title"
    initiative = create(:initiative)
    initiative.title = different_title

    include = {
      source: { only: [:id] },
      parent: { only: [:id] }
    }
    expect { post initiatives_path, params: initiative.as_json(include:), as: :json }
      .to change(Initiative, :all)

    db_initiative = Initiative.find_by(title: different_title)

    expect(db_initiative).not_to be_nil

    expect(response.body).to eq(db_initiative.to_json(include:))
  end

  it "DELETE /initiatives/:initiative_id" do
    delete initiative_path(initiative)
    expect(response).to have_http_status(:no_content)
  end
end
