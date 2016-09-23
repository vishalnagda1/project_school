require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  before(:each) do
    @school = FactoryGirl.create(:school)
    @subject = FactoryGirl.create(:subject, :school_id=>@school.id)
    @classroom = FactoryGirl.create(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
  end
  describe "GET #index" do
    it "populates a list of teachers" do
      teacher = FactoryGirl.create(:teacher, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
      get :index
      assigns(:teachers).should eq([teacher])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #index_by_school_id" do
    it "populates a list of teachers by school id" do
      teacher = FactoryGirl.create(:teacher, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
      get :index_by_school_id, :format=>@school.id
      assigns(:teachers).should eq([teacher])
    end

    it "should not populates a list of teachers by school id" do
      school1 = FactoryGirl.create(:school)
      teacher = FactoryGirl.create(:teacher, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
      teacher1 = FactoryGirl.create(:teacher, :school_id => school1.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
      get :index_by_school_id, :format=>@school.id
      assigns(:teachers).should_not eq([teacher1])
      assigns(:teachers).should eq([teacher])
    end

    it "renders the :index_by_school_id view" do
      get :index_by_school_id, :format=>@school.id
      response.should render_template :index_by_school_id
    end
  end
  describe "GET #show" do
    it "assigns the requested teacher to @teacher" do
      teacher = FactoryGirl.create(:teacher, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
      get :show, id: teacher
      assigns(:teacher).should eq(teacher)
    end

    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:teacher, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
      response.should render_template :show
    end
  end
  context "GET new" do
    it "should assign a new teacher to @teacher" do
      get :new
      expect(assigns(:teacher)).to be_a_new(Teacher)
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new teacher" do
        expect{
          post :create, teacher: FactoryGirl.attributes_for(:teacher, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
        }.to change(Teacher,:count).by(1)
      end

      it "redirects to the new teacher" do
        post :create, teacher: FactoryGirl.attributes_for(:teacher, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
        response.should redirect_to Teacher.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new teacher" do
        expect{
          post :create, teacher: FactoryGirl.attributes_for(:teacher, :name=>nil, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
        }.to_not change(Teacher,:count)
      end

      it "re-renders the new method" do
        post :create, teacher: FactoryGirl.attributes_for(:teacher, :name=>nil, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
        response.should render_template :new
      end
    end
  end
  describe 'PUT update' do
    before :each do
      @teacher = FactoryGirl.create(:teacher, name: "DummyName", :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
    end

    context "valid attributes" do
      it "located the requested @teacher" do
        put :update, id: @teacher, teacher: FactoryGirl.attributes_for(:teacher, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
        assigns(:teacher).should eq(@teacher)
      end

      it "changes @teacher's attributes" do
        put :update, id: @teacher, teacher: FactoryGirl.attributes_for(:teacher, name: "Dummy", :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
        @teacher.reload
        @teacher.name.should eq("Dummy")
      end

      it "redirects to the updated teacher" do
        put :update, id: @teacher, teacher: FactoryGirl.attributes_for(:teacher, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
        response.should redirect_to @teacher
      end
    end

    context "invalid attributes" do
      it "locates the requested @teacher" do
        put :update, id: @teacher, teacher: FactoryGirl.attributes_for(:teacher, name: nil, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
        assigns(:teacher).should eq(@teacher)
      end

      it "does not change @teacher's attributes" do
        put :update, id: @teacher,
            teacher: FactoryGirl.attributes_for(:teacher, name: nil, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
        @teacher.reload
        @teacher.name.should eq(@teacher.name)
      end

      it "re-renders the edit method" do
        put :update, id: @teacher, teacher: FactoryGirl.attributes_for(:teacher, name: nil, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
        response.should render_template :edit
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @teacher = FactoryGirl.create(:teacher, :school_id => @school.id, :subject_ids=>[@subject.id], :classroom_ids=>[@classroom.id])
    end

    it "deletes the teacher" do
      expect{
        delete :destroy, id: @teacher
      }.to change(Teacher,:count).by(-1)
    end

    it "redirects to teachers#index" do
      delete :destroy, id: @teacher
      response.should redirect_to teachers_url
    end
  end
end
