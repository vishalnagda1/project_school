require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  before(:each) do
    @school = FactoryGirl.create(:school)
    @subject = FactoryGirl.create(:subject, :school_id=>@school.id)
    @classroom = FactoryGirl.create(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
  end
  describe "GET #index" do
    it "populates a list of students" do
      student = FactoryGirl.create(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
      get :index
      assigns(:students).should eq([student])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #index_by_classroom_id" do
    it "populates a list of students by classroom id" do
      student = FactoryGirl.create(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
      get :index_by_classroom_id, :format=>@classroom.id
      assigns(:students).should eq([student])
    end

    it "should not populates a list of students by classroom id" do
      school1 = FactoryGirl.create(:school)
      student = FactoryGirl.create(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
      student1 = FactoryGirl.create(:student, :school_id => school1.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
      get :index_by_classroom_id, :format=>@classroom.id
      assigns(:students).should_not eq([student1])
    end

    it "renders the :index_by_classroom_id view" do
      get :index_by_classroom_id, :format=>@classroom.id
      response.should render_template :index_by_classroom_id
    end
  end
  describe "GET #show" do
    it "assigns the requested student to @student" do
      student = FactoryGirl.create(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
      get :show, id: student
      assigns(:student).should eq(student)
    end

    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
      response.should render_template :show
    end
  end
  context "GET new" do
    it "should assign a new student to @student" do
      get :new
      expect(assigns(:student)).to be_a_new(Student)
    end
  end
  describe "GET 'edit'" do
    before {
      @student = FactoryGirl.create(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
      get :edit, :id => @student.id
    }

    it "assigns @student" do
      expect(assigns(:student)).to eq(@student)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new student" do
        expect{
          post :create, student: FactoryGirl.attributes_for(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
        }.to change(Student,:count).by(1)
      end

      it "redirects to the new student" do
        post :create, student: FactoryGirl.attributes_for(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
        response.should redirect_to Student.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new student" do
        expect{
          post :create, student: FactoryGirl.attributes_for(:student, :name=>nil, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
        }.to_not change(Student,:count)
      end

      it "re-renders the new method" do
        post :create, student: FactoryGirl.attributes_for(:student, :name=>nil, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
        response.should render_template :new
      end
    end
  end
  describe 'PUT update' do
    before :each do
      @student = FactoryGirl.create(:student, name: "DummyName", :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
    end

    context "valid attributes" do
      it "located the requested @student" do
        put :update, id: @student, student: FactoryGirl.attributes_for(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
        assigns(:student).should eq(@student)
      end

      it "changes @student's attributes" do
        put :update, id: @student, student: FactoryGirl.attributes_for(:student, name: "Dummy", :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
        @student.reload
        @student.name.should eq("Dummy")
      end

      it "redirects to the updated student" do
        put :update, id: @student, student: FactoryGirl.attributes_for(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
        response.should redirect_to @student
      end
    end

    context "invalid attributes" do
      it "locates the requested @student" do
        put :update, id: @student, student: FactoryGirl.attributes_for(:student, name: nil, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
        assigns(:student).should eq(@student)
      end

      it "does not change @student's attributes" do
        put :update, id: @student,
            student: FactoryGirl.attributes_for(:student, name: nil, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
        @student.reload
        @student.name.should eq(@student.name)
      end

      it "re-renders the edit method" do
        put :update, id: @student, student: FactoryGirl.attributes_for(:student, name: nil, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
        response.should render_template :edit
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @student = FactoryGirl.create(:student, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_id=>@classroom.id)
    end

    it "deletes the student" do
      expect{
        delete :destroy, id: @student
      }.to change(Student,:count).by(-1)
    end

    it "redirects to students#index" do
      delete :destroy, id: @student
      response.should redirect_to students_url
    end
  end
end
