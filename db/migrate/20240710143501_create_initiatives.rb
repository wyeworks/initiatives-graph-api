# frozen_string_literal: true

class CreateInitiatives < ActiveRecord::Migration[7.1]
  def change
    create_table :initiatives do |t|
      t.string :title, null: false
      t.string :description
      t.integer :status
      t.date :startdate
      t.references :parent, foreign_key: { to_table: :initiatives }

      t.timestamps
    end
  end
end
