class Teacher < ActiveRecord::Base
  validates_presence_of :name, :gender, :phone
end
