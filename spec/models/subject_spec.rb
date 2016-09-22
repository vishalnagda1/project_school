require 'rails_helper'

RSpec.describe Subject, type: :model do
  context 'validation' do
    ["name"].each do |field|
      it "should be invalid if #{field} is not present" do
        FactoryGirl.build(:school, "#{field}".to_sym => nil).should_not be_valid
      end
    end

    it { should validate_presence_of(:school_id) }
    it { should validate_numericality_of(:school_id) }
  end
end
