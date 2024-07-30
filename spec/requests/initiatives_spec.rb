# frozen_string_literal: true

RSpec.describe "Initiatives Endpoint", type: :request do
  # index
  # show
  # create
  # update
  # destroy

  let!(:initiatives) { create_list(:initiative, 5) }

  let(:initiative_titles) { initiatives.map(&:title) }

  it "shows all initiatives" do
    get "/initiatives"
    expect(response.body).to include(*initiative_titles)
  end
end
