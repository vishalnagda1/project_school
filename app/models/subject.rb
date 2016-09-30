class Subject < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :classrooms
  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :students

  validates_presence_of :name, :school_id
  validates_numericality_of :school_id
  # validates_uniqueness_of :name
end
