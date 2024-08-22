# frozen_string_literal: true

class SeparateSourceAndHelpersRel < ActiveRecord::Migration[7.1]
  def change
    # add helpers table
    create_table :initiatives_wyeworkers,
                 primary_key: %i[wyeworker_id initiative_id] do |t|
      t.references :initiative, null: false, foreign_key: { on_delete: :cascade }
      t.references :wyeworker, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end

    # add source column
    add_reference :initiatives, :owner, null: false, foreign_key: { to_table: :wyeworkers }

    reversible do |direction|
      direction.up do
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
      end
    end
  end
end
