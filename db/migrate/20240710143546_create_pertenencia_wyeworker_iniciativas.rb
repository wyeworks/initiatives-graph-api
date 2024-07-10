class CreatePertenenciaWyeworkerIniciativas < ActiveRecord::Migration[7.1]
  def change
    create_table :pertenencia_wyeworker_iniciativas do |t|
      t.integer :tipo
      t.references :iniciativa, null: false, foreign_key: true
      t.references :wyeworker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
