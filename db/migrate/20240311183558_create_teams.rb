class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :manager, foreign_key: { to_table: :employees }

      t.timestamps
    end
  end
end
