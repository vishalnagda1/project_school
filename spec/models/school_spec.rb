require 'rails_helper'

RSpec.describe School, type: :model do
  context 'validation' do
    ["name", "address", "city", "state", "zipcode", "phone"].each do |field|
      it "should be invalid if #{field} is not present" do
        FactoryGirl.build(:school, "#{field}".to_sym => nil).should_not be_valid
      end
    end

    it { should validate_numericality_of(:phone) }
    it { should validate_numericality_of(:zipcode) }
    it { should validate_length_of(:phone).is_at_least(10) }
  end
end
