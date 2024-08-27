class AddDeleteCascadeForSourcesAndInitiatives < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :initiatives, :wyeworkers, column: :owner_id
    add_foreign_key :initiatives, :wyeworkers, column: :owner_id, on_delete: :cascade
  end
end
