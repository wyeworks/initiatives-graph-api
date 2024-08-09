class AddDeleteCascadeForWyeworkersAndInitiatives < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
      change_table :wyeworker_initiative_belongings do
        direction.up do
          drop_table :wyeworker_initiative_belongings, # Need to drop the whole table because annotate won't work otherwise
                     primary_key: %i[wyeworker_id initiative_id] do |t|
            t.string :kind
            t.belongs_to :initiative, null: false, foreign_key: true
            t.belongs_to :wyeworker, null: false, foreign_key: true
          end
          create_table :wyeworker_initiative_belongings,
                       primary_key: %i[wyeworker_id initiative_id] do |t|
            t.string :kind
            t.belongs_to :initiative, null: false, foreign_key: { on_delete: :cascade }
            t.belongs_to :wyeworker, null: false, foreign_key: { on_delete: :cascade }
          end
        end
        direction.down do
          drop_table :wyeworker_initiative_belongings,
                     primary_key: %i[wyeworker_id initiative_id] do |t|
            t.string :kind
            t.belongs_to :initiative, null: false, foreign_key: { on_delete: :cascade }
            t.belongs_to :wyeworker, null: false, foreign_key: { on_delete: :cascade }
          end
          create_table :wyeworker_initiative_belongings,
                       primary_key: %i[wyeworker_id initiative_id] do |t|
            t.string :kind
            t.belongs_to :initiative, null: false, foreign_key: true
            t.belongs_to :wyeworker, null: false, foreign_key: true
          end
        end
      end
    end
  end
end
