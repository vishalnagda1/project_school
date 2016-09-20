class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.integer :no_of_students
      t.references :school, index: true

      t.timestamps null: false
    end
    add_foreign_key :classrooms, :schools
  end
end
