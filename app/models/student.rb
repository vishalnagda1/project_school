class Student < ActiveRecord::Base
  validates_presence_of :name, :father_name, :mother_name, :address, :city, :state, :zipcode, :phone
end
