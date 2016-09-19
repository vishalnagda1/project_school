class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.text :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone

      t.timestamps null: false
    end
  end
end
