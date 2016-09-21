class Classroom < ActiveRecord::Base
  belongs_to :school

  validates_presence_of :name, :no_of_students, :school_id
  validates_numericality_of :no_of_students
  validates_uniqueness_of :name
end
