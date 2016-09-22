School.create(:name=>"Dummy School 1", :address=>"Dummy Address", :city=>"Dummy City", :state=>"Dummy State", :zipcode=>"123456", :phone=>"1234567890")
School.create(:name=>"Dummy School 2", :address=>"Dummy Address", :city=>"Dummy City", :state=>"Dummy State", :zipcode=>"123456", :phone=>"1234567890")

Subject.create(:name=>"Dummy Subject 1", :school_id=>1)
Subject.create(:name=>"Dummy Subject 2", :school_id=>1)
Subject.create(:name=>"Dummy Subject 3", :school_id=>2)
Subject.create(:name=>"Dummy Subject 4", :school_id=>2)
Subject.create(:name=>"Dummy Subject 5", :school_id=>2)
Subject.create(:name=>"Dummy Subject 6", :school_id=>2)

Classroom.create(:name=>"Dummy Classroom 1", :no_of_students=>10, :school_id=>1, :subject_ids=>[])