class AddSchoolRefToModels < ActiveRecord::Migration
  def change
    add_reference :classrooms, :school, foreign_key: true
    add_reference :subjects, :school, foreign_key: true
    add_reference :teachers, :school, foreign_key: true
    add_reference :students, :school, foreign_key: true
  end
end
