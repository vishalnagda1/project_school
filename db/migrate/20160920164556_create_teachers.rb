class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :gender
      t.string :phone

      t.timestamps null: false
    end
  end
end
