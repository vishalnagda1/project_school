require 'rails_helper'

RSpec.describe Student, type: :model do
  context 'validation' do
    ["name", "father_name", "mother_name", "address", "city", "state", "zipcode", "phone", "school_id", "classroom_id"].each do |field|
      it "should be invalid if #{field} is not present" do
        FactoryGirl.build(:student, "#{field}".to_sym => nil).should_not be_valid
      end
    end

    it { should validate_numericality_of(:phone) }
    it { should validate_numericality_of(:zipcode) }
    it { should validate_numericality_of(:school_id) }
    it { should validate_numericality_of(:classroom_id) }
    it { should validate_length_of(:phone).is_at_least(10) }
  end
end
