class Classroom < ActiveRecord::Base
  validates_presence_of :name, :no_of_students
  validates_numericality_of :no_of_students
end
