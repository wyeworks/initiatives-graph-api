# frozen_string_literal: true

%w[developer manager].each do |wyeworker_kind|
  RSpec.describe "#{wyeworker_kind.titleize} Endpoint", type: :request do
    let!(:wyeworkers) { create_list(wyeworker_kind.to_sym, 5) }
    let(:wyeworker_names) { wyeworkers.map(&:name) }

    it "shows all #{wyeworker_kind.pluralize}" do
      get "/#{wyeworker_kind.pluralize}"
      expect(response.body).to include(*wyeworker_names)
    end

    it "singles out one #{wyeworker_kind}" do
      get "/#{wyeworker_kind.pluralize}/#{wyeworkers.first.id}"
      expect(response.body).to include(wyeworkers.first.name)
    end

    it "creates a #{wyeworker_kind}" do
      w = build(wyeworker_kind.to_sym)

      post "/#{wyeworker_kind.pluralize}", params: { wyeworker_kind => w.as_json }
      expect(response).to have_http_status(:created)
      expect(response.body).to include(w.name)
    end

    it "updates a #{wyeworker_kind}" do
      different_name = "A different initiative name"

      put "/#{wyeworker_kind.pluralize}/#{wyeworkers.first.id}",
          params: { wyeworker_kind => { name: different_name } }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(different_name)
    end

    it "deletes a #{wyeworker_kind}" do
      delete "/#{wyeworker_kind.pluralize}/#{wyeworkers.first.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
