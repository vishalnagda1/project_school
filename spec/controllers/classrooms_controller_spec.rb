require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  before(:each) do
    @school = FactoryGirl.create(:school)
    @subject = FactoryGirl.create(:subject, :school_id=>@school.id)
  end
  describe "GET #index" do
    it "populates an list of classrooms" do
      classroom = FactoryGirl.create(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
      get :index
      assigns(:classrooms).should eq([classroom])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #index_by_school_id" do
    it "populates an list of classrooms by school id" do
      classroom = FactoryGirl.create(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
      get :index_by_school_id, :format=>@school.id
      assigns(:classrooms).should eq(School.find(classroom.school_id).classrooms)
    end

    it "should not populates an list of classrooms by school id" do
      school1 = FactoryGirl.create(:school)
      classroom = FactoryGirl.create(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
      classroom1 = FactoryGirl.create(:classroom, :school_id => school1.id, :subject_ids=>[@subject.id])
      get :index_by_school_id, :format=>@school.id
      assigns(:classrooms).should_not eq(School.find(classroom1.school_id).classrooms)
    end

    it "renders the :index_by_school_id view" do
      get :index_by_school_id, :format=>@school.id
      response.should render_template :index_by_school_id
    end
  end
  describe "GET #show" do
    it "assigns the requested classroom to @classroom" do
      classroom = FactoryGirl.create(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
      get :show, id: classroom
      assigns(:classroom).should eq(classroom)
    end

    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
      response.should render_template :show
    end
  end
  context "GET new" do
    it "should assign a new classroom to @classroom" do
      get :new
      expect(assigns(:classroom)).to be_a_new(Classroom)
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new classroom" do
        expect{
          post :create, classroom: FactoryGirl.attributes_for(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
        }.to change(Classroom,:count).by(1)
      end

      it "redirects to the new classroom" do
        post :create, classroom: FactoryGirl.attributes_for(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
        response.should redirect_to Classroom.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new classroom" do
        expect{
          post :create, classroom: FactoryGirl.attributes_for(:classroom, :name=>nil, :school_id => @school.id, :subject_ids=>[@subject.id])
        }.to_not change(Classroom,:count)
      end

      it "re-renders the new method" do
        post :create, classroom: FactoryGirl.attributes_for(:classroom, :name=>nil, :school_id => @school.id, :subject_ids=>[@subject.id])
        response.should render_template :new
      end
    end
  end
  describe 'PUT update' do
    before :each do
      @classroom = FactoryGirl.create(:classroom, name: "DummyName", :school_id => @school.id, :subject_ids=>[@subject.id])
    end

    context "valid attributes" do
      it "located the requested @classroom" do
        put :update, id: @classroom, classroom: FactoryGirl.attributes_for(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
        assigns(:classroom).should eq(@classroom)
      end

      it "changes @classroom's attributes" do
        put :update, id: @classroom, classroom: FactoryGirl.attributes_for(:classroom, name: "Dummy", :school_id => @school.id, :subject_ids=>[@subject.id])
        @classroom.reload
        @classroom.name.should eq("Dummy")
      end

      it "redirects to the updated classroom" do
        put :update, id: @classroom, classroom: FactoryGirl.attributes_for(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
        response.should redirect_to @classroom
      end
    end

    context "invalid attributes" do
      it "locates the requested @classroom" do
        put :update, id: @classroom, classroom: FactoryGirl.attributes_for(:classroom, name: nil, :school_id => @school.id, :subject_ids=>[@subject.id])
        assigns(:classroom).should eq(@classroom)
      end

      it "does not change @classroom's attributes" do
        put :update, id: @classroom,
            classroom: FactoryGirl.attributes_for(:classroom, name: nil, :school_id => @school.id, :subject_ids=>[@subject.id])
        @classroom.reload
        @classroom.name.should eq(@classroom.name)
      end

      it "re-renders the edit method" do
        put :update, id: @classroom, classroom: FactoryGirl.attributes_for(:classroom, name: nil, :school_id => @school.id, :subject_ids=>[@subject.id])
        response.should render_template :edit
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @classroom = FactoryGirl.create(:classroom, :school_id => @school.id, :subject_ids=>[@subject.id])
    end

    it "deletes the classroom" do
      expect{
        delete :destroy, id: @classroom
      }.to change(Classroom,:count).by(-1)
    end

    it "redirects to classrooms#index" do
      delete :destroy, id: @classroom
      response.should redirect_to classrooms_url
    end
  end
end
