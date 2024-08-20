# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  def as_json(...)
    json = super(...)
    json["resource_link"] = Rails.application.routes.url_helpers.url_for(self)
    json
  end
end
