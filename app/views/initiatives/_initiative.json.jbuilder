# frozen_string_literal: true

json.merge! initiative.as_json
json.owner do
  json.id initiative.owner_id if initiative.owner_id
end
json.parent do
  json.id initiative.parent_id if initiative.parent_id
end
