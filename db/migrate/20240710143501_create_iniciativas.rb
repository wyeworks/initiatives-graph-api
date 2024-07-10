class CreateIniciativas < ActiveRecord::Migration[7.1]
  def change
    create_table :iniciativas do |t|
      t.string :descripcion
      t.integer :status
      t.date :fechaInicio
      t.references :padre, foreign_key: { to_table: :iniciativas }

      t.timestamps
    end
  end
end
