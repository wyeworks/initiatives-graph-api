# frozen_string_literal: true

require "rails_helper"

%w[developer manager].each do |wyeworker_kind|
  RSpec.describe "#{wyeworker_kind.pluralize.titleize} Endpoint", type: :request do
    let!(:wyeworkers) { create_list(wyeworker_kind.to_sym, 5) }
    let(:wyeworker_names) { wyeworkers.map(&:name) }

    it "GET /#{wyeworker_kind.pluralize}" do
      get "/#{wyeworker_kind.pluralize}"
      expect(response.body).to eq(wyeworkers.to_json)
    end

    it "GET /#{wyeworker_kind.pluralize}/:#{wyeworker_kind}_id" do
      get "/#{wyeworker_kind.pluralize}/#{wyeworkers.first.id}"
      expect(response.body).to eq(wyeworkers.first.to_json)
    end

    it "POST /#{wyeworker_kind.pluralize}" do
      wyeworker = build(wyeworker_kind.to_sym)

      post "/#{wyeworker_kind.pluralize}", params: wyeworker.as_json, as: :json
      expect(response).to have_http_status(:created)
      expect(response.body).to include(wyeworker.name)
    end

    it "PUT /#{wyeworker_kind.pluralize}" do
      different_name = "A different initiative name"

      put "/#{wyeworker_kind.pluralize}/#{wyeworkers.first.id}",
          params: { wyeworker_kind => { name: different_name } },
          as: :json
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(different_name)
    end

    it "DELETE /#{wyeworker_kind.pluralize}/:#{wyeworker_kind}_id" do
      delete "/#{wyeworker_kind.pluralize}/#{wyeworkers.first.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
