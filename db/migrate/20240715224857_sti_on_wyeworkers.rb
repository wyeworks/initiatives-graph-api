class StiOnWyeworkers < ActiveRecord::Migration[7.1]
  def change
    add_column :wyeworkers, :type, :string
  end
end
