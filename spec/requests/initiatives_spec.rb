# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Initiatives Endpoint", type: :request do
  let(:initiative) { create(:initiative) }
  let(:initiatives) { create_list(:initiative, 5) << initiative }

  it "GET /initiatives" do
    initiatives
    all_db_initiatives = Initiative.all
    get initiatives_path, as: :json
    expect(response.parsed_body).to eq(all_db_initiatives.as_json)
  end

  it "GET /initiatives/:initiative_id" do
    get initiative_path(initiative), as: :json
    expect(response.parsed_body).to eq(initiative.as_json)
  end

  it "POST /initiatives" do
    initiative_attibutes = attributes_for(:initiative)
    initiative_attibutes[:owner_id] = create(:manager).id

    expect { post initiatives_path, params: initiative_attibutes, as: :json }
      .to change {
            Initiative.all.count
          }.by 1

    expect(response).to have_http_status(:created)

    db_initiative = Initiative.find_by(title: initiative_attibutes[:title])
    expect(db_initiative).not_to be_nil

    expect(response.parsed_body).to eq(db_initiative.as_json)
  end

  it "PUT /initiatives" do
    different_title = "A different initiative title"
    initiative = create(:initiative)
    initiative.title = different_title

    expect { put initiative_path(initiative.id), params: initiative.as_json, as: :json }
      .to change(Initiative, :all)

    db_initiative = Initiative.find_by(title: different_title)

    expect(db_initiative).not_to be_nil

    expect(response.parsed_body).to eq(db_initiative.as_json)
  end

  it "DELETE /initiatives/:initiative_id" do
    delete initiative_path(initiative), as: :json
    expect(response).to have_http_status(:no_content)
  end
end
