class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :father_name
      t.string :mother_name
      t.text :address
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :phone

      t.timestamps null: false
    end
  end
end
