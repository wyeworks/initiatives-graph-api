# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Initiatives Endpoint", type: :request do
  let(:initiatives) { create_list(:initiative, 5) }

  it "GET /initiatives" do
    initiatives
    all_db_initiatives = Initiative.all
    get initiatives_path, as: :json
    expect(response.parsed_body).to eq(all_db_initiatives.as_json(include: {
                                                                    owner: { only: [:id] },
                                                                    parent: { only: [:id] }
                                                                  }))
  end

  it "GET /initiatives/:initiative_id" do
    initiative = initiatives.sample
    get initiative_path(initiative), as: :json
    expect(response.parsed_body).to eq(initiative.as_json(include: {
                                                            owner: { only: [:id] },
                                                            parent: { only: [:id] }
                                                          }))
  end

  it "POST /initiatives" do
    initiative = attributes_for(:initiative)
    initiative[:owner_id] = initiative.delete(:owner).id

    expect { post initiatives_path, params: initiative, as: :json }
      .to change {
            Initiative.all.count
          }.by 1

    db_initiative = Initiative.find_by(title: initiative[:title])
    expect(db_initiative).not_to be_nil

    expect(response.parsed_body).to eq(db_initiative.as_json(include: {
                                                               owner: { only: [:id] },
                                                               parent: { only: [:id] }
                                                             }))
  end

  it "PUT /initiatives" do
    different_title = "A different initiative title"
    initiative = create(:initiative)
    initiative.title = different_title

    include = {
      owner: { only: [:id] },
      parent: { only: [:id] }
    }
    expect { put initiative_path(initiative.id), params: initiative.as_json(include:), as: :json }
      .to change(Initiative, :all)

    db_initiative = Initiative.find_by(title: different_title)

    expect(db_initiative).not_to be_nil

    expect(response.parsed_body).to eq(db_initiative.as_json(include:))
  end

  it "DELETE /initiatives/:initiative_id" do
    initiative = initiatives.sample
    delete initiative_path(initiative)
    expect(response).to have_http_status(:no_content)
  end
end
