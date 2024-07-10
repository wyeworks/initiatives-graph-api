class CreateWyeworkers < ActiveRecord::Migration[7.1]
  def change
    create_table :wyeworkers do |t|
      t.string :name

      t.timestamps
    end
  end
end
