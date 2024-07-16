class DescriptionForInitiatives < ActiveRecord::Migration[7.1]
  def change
    add_column :initiatives, :type, :string
  end
end
