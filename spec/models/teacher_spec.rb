require 'rails_helper'

RSpec.describe Teacher, type: :model do
  context 'validation' do
    ["name", "gender", "phone", "school_id"].each do |field|
      it "should be invalid if #{field} is not present" do
        FactoryGirl.build(:teacher, "#{field}".to_sym => nil).should_not be_valid
      end
    end

    it { should validate_numericality_of(:phone) }
    it { should validate_numericality_of(:school_id) }
    it { should validate_length_of(:phone).is_at_least(10) }
    it { is_expected.to validate_inclusion_of(:gender).in_array(%w(Male Female)) }
  end
end
