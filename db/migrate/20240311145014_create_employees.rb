class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :mobile
      t.references :team, foreign_key: true
      t.boolean :is_manager

      t.timestamps
    end
  end
end
