class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :author
      t.integer :state, default: 0, null: false
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :courses, :name
  end
end
