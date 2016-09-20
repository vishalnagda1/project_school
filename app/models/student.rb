class Student < ActiveRecord::Base
  belongs_to :school

  validates_presence_of :name, :father_name, :mother_name, :address, :city, :state, :zipcode, :phone
  validates_numericality_of :zipcode, :phone
  validates_length_of :phone, :minimum => 10, :maximum => 10
end
