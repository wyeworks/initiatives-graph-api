class CreateWyeworkerInitiativeBelonging < ActiveRecord::Migration[7.1]
  def change
    create_table :wyeworker_initiative_belongings,
      primary_key: [:wyeworker_id, :initiative_id] do |t|
        t.string :kind
        t.belongs_to :initiative, null: false, foreign_key: true
        t.belongs_to :wyeworker, null: false, foreign_key: true
    end
  end
end
