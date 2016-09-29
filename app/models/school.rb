class School < ActiveRecord::Base
  has_many :classrooms
  has_many :subjects
  has_many :teachers
  has_many :students

  validates_presence_of :name, :address, :city, :state, :zipcode, :phone
  validates_numericality_of :phone
  validates_length_of :phone, :minimum => 10, :maximum => 10
end
