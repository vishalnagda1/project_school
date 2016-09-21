class Teacher < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :subjects

  validates_presence_of :name, :gender, :phone
  validates_numericality_of :phone
  validates_length_of :phone, :minimum => 10, :maximum => 10
end
