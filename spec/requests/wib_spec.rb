# frozen_string_literal: true

RSpec.describe "Wyeworker Initiative Belonging Endpoint", type: :request do
  include RestJsonUtils

  let!(:initiatives) { create_list(:initiative, 5) }
  let(:wibs) do
    initiatives.map(&:source_initiative_belonging).concat initiatives.flat_map(&:helper_initiative_belongings)
  end
  let(:wib_ids) { wibs.map(&:id) }
  let(:wib_ids_strings) { wib_ids.map { |id_arr| id_arr.map(&:to_s) } }

  # index
  it "shows all wyeworker initiative belongings" do
    get "/wyeworker_initiative_belongings"
    expect(response.body).to include(*wib_ids_strings.flatten)
  end

  # show
  it "singles out one wyeworker initiative belonging" do
    get "/wyeworker_initiative_belongings/#{wib_ids_strings.first.join('_')}"
    expect(response.body).to include(*wib_ids_strings.first.flatten)
  end

  # create
  it "creates a wyeworker initiative belonging" do
    i = create(:initiative)
    w = create(:wyeworker)

    post "/wyeworker_initiative_belongings",
         params: {
           wyeworker_initiative_belonging: {
             kind: "helper"
           },
           initiative: initiative_to_url(i),
           wyeworker: wyeworker_to_url(w)
         }

    expect(response).to have_http_status(:created)
    expect(response.body).to include(i.id.to_s, w.id.to_s)
  end

  # destroy
  it "forbids deleting a source wyeworker initiative belonging" do
    delete "/wyeworker_initiative_belongings/#{wib_ids_strings.first.join('_')}"
    expect(response).to have_http_status(:no_content)
  end
end
