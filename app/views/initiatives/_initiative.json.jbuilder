# frozen_string_literal: true

json.merge! initiative.as_json
json.owner do
  json.id initiative.owner_id
end
