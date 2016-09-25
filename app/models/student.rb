class Student < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :subjects
  belongs_to :classroom
  has_and_belongs_to_many :teachers

  validates_presence_of :name, :father_name, :mother_name, :address, :city, :state, :zipcode, :phone, :school_id, :classroom_id
  validates_numericality_of :zipcode, :phone, :school_id, :classroom_id
  validates_length_of :phone, :minimum => 10, :maximum => 10

  # def school_details
  #   self.school
  # end
  #
  # def classroom_details
  #   self.classroom
  # end
  #
  # def subjects_details
  #   self.subjects
  # end
  #
  # def teachers_details
  #   self.subjects.each  do |t|
  #     t.teachers
  #   end
  # end
end
