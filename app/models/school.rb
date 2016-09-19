class School < ActiveRecord::Base
  validates_presence_of :name, :address, :city, :state, :zipcode, :phone
end
