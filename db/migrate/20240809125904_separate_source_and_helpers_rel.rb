class SeparateSourceAndHelpersRel < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
      direction.up do
        # add helpers table
        create_table :initiative_helpers,
                     primary_key: %i[helper_id initiative_id] do |t|
          t.references :initiative, null: false, foreign_key: { on_delete: :cascade }
          t.references :helper, null: false, foreign_key: { to_table: :wyeworkers, on_delete: :cascade }
          t.timestamps default: -> { "CURRENT_TIMESTAMP" }
        end

        # add source column
        add_reference :initiatives, :source, foreign_key: { to_table: :wyeworkers }

        # move source to source column
        execute "UPDATE initiatives "\
                "SET source_id = (
                  SELECT wyeworker_id
                  FROM wyeworker_initiative_belongings
                  WHERE kind='source' AND initiative_id=initiatives.id
                );"

        # make initiatives.source_id not null now that it has values
        change_column_null :initiatives, :source_id, false

        # move helper-initiative to helpers table
        execute %{
          INSERT INTO initiative_helpers
          (initiative_id, helper_id)
          SELECT initiative_id, wyeworker_id
          FROM wyeworker_initiative_belongings
          WHERE kind='helper'
        }

        # drop weird table
        drop_table :wyeworker_initiative_belongings
      end
      direction.down do
        # add weird table
        create_table :wyeworker_initiative_belongings,
                     primary_key: %i[wyeworker_id initiative_id] do |t|
          t.string :kind
          t.belongs_to :initiative, null: false, foreign_key: { on_delete: :cascade }
          t.belongs_to :wyeworker, null: false, foreign_key: { on_delete: :cascade }
          t.timestamps
        end
        # copy source to weird table
        # copy helpers to weird table
        # drop helpers table
        drop_table :initiative_helpers
        # drop source column
        remove_column :initiatives, :source_id
      end
    end
  end
end
