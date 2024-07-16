class UniqueNamesAndTitles < ActiveRecord::Migration[7.1]
  def change
    add_index :wyeworkers, :name, unique: true
    add_index :initiatives, :title, unique: true
  end
end
