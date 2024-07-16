# == Schema Information
#
# Table name: wyeworkers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Manager < Wyeworker
  before_create do
    self.name = self.name || "Anonymous manager"
  end
end
