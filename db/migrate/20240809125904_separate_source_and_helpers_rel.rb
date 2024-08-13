# frozen_string_literal: true

class SeparateSourceAndHelpersRel < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
      direction.up do
        # add helpers table
        create_table :initiative_helpers,
                     primary_key: %i[helper_id initiative_id] do |t|
          t.references :initiative, null: false, foreign_key: { on_delete: :cascade }
          t.references :helper, null: false, foreign_key: { to_table: :wyeworkers, on_delete: :cascade }
          t.timestamps
        end

        # add source column
        add_reference :initiatives, :source, null: false, foreign_key: { to_table: :wyeworkers }

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

        # drop helpers table
        drop_table :initiative_helpers

        # drop source column
        remove_column :initiatives, :source_id
      end
    end
  end
end
