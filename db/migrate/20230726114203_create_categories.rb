class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :state, default: true
      t.belongs_to :vertical, null: false, foreign_key: true

      t.timestamps
    end

    add_index :categories, :name, unique: true
  end
end
