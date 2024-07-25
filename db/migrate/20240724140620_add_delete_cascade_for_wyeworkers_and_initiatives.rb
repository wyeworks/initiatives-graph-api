class AddDeleteCascadeForWyeworkersAndInitiatives < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
      change_table :wyeworker_initiative_belongings do
        direction.up do
          remove_foreign_key :wyeworker_initiative_belongings, :initiatives
          add_foreign_key :wyeworker_initiative_belongings,
                          :initiatives,
                          null: false,
                          foreign_key: { on_delete: :cascade }
        end
        direction.down do
          remove_foreign_key :wyeworker_initiative_belongings, :initiatives
          add_foreign_key :wyeworker_initiative_belongings, :initiatives, null: false
        end
      end
    end
  end
end
