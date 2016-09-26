require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  before(:each) do
    @school = FactoryGirl.create(:school)
  end
  describe "GET #index" do
    it "populates a list of subjects" do
      subject = FactoryGirl.create(:subject, :school_id => @school.id)
      get :index
      assigns(:subjects).should eq([subject])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #index_by_school_id" do
    it "populates a list of subjects by school id" do
      subject = FactoryGirl.create(:subject, :school_id => @school.id)
      get :index_by_school_id, :format=>@school.id
      assigns(:subjects).should eq([subject])
    end

    it "should not populates a list of subjects by school id" do
      school1 = FactoryGirl.create(:school)
      subject = FactoryGirl.create(:subject, :school_id => @school.id)
      subject1 = FactoryGirl.create(:subject, :school_id => school1.id)
      get :index_by_school_id, :format=>@school.id
      assigns(:subjects).should_not eq([subject1])
      assigns(:subjects).should eq([subject])
    end

    it "renders the :index_by_school_id view" do
      get :index_by_school_id, :format=>@school.id
      response.should render_template :index_by_school_id
    end
  end
  describe "GET #show" do
    it "assigns the requested subject to @subject" do
      subject = FactoryGirl.create(:subject, :school_id => @school.id)
      get :show, id: subject
      assigns(:subject).should eq(subject)
    end

    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:subject, :school_id => @school.id)
      response.should render_template :show
    end
  end
  context "GET new" do
    it "should assign a new subject to @subject" do
      get :new
      expect(assigns(:subject)).to be_a_new(Subject)
    end
  end
  describe "GET 'edit'" do
    before {
      @subject = FactoryGirl.create(:subject, :school_id => @school.id)
      get :edit, :id => @subject.id
    }

    it "assigns @subject" do
      expect(assigns(:subject)).to eq(@subject)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new subject" do
        expect{
          post :create, subject: FactoryGirl.attributes_for(:subject, :school_id => @school.id)
        }.to change(Subject,:count).by(1)
      end

      it "redirects to the new subject" do
        post :create, subject: FactoryGirl.attributes_for(:subject, :school_id => @school.id)
        response.should redirect_to Subject.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new subject" do
        expect{
          post :create, subject: FactoryGirl.attributes_for(:subject, :name=>nil, :school_id => @school.id)
        }.to_not change(Subject,:count)
      end

      it "re-renders the new method" do
        post :create, subject: FactoryGirl.attributes_for(:subject, :name=>nil, :school_id => @school.id)
        response.should render_template :new
      end
    end
  end
  describe 'PUT update' do
    before :each do
      @subject = FactoryGirl.create(:subject, name: "DummyName", :school_id => @school.id)
    end

    context "valid attributes" do
      it "located the requested @subject" do
        put :update, id: @subject, subject: FactoryGirl.attributes_for(:subject, :school_id => @school.id)
        assigns(:subject).should eq(@subject)
      end

      it "changes @subject's attributes" do
        put :update, id: @subject, subject: FactoryGirl.attributes_for(:subject, name: "Dummy", :school_id => @school.id)
        @subject.reload
        @subject.name.should eq("Dummy")
      end

      it "redirects to the updated subject" do
        put :update, id: @subject, subject: FactoryGirl.attributes_for(:subject, :school_id => @school.id)
        response.should redirect_to @subject
      end
    end

    context "invalid attributes" do
      it "locates the requested @subject" do
        put :update, id: @subject, subject: FactoryGirl.attributes_for(:subject, name: nil, :school_id => @school.id)
        assigns(:subject).should eq(@subject)
      end

      it "does not change @subject's attributes" do
        put :update, id: @subject,
            subject: FactoryGirl.attributes_for(:subject, name: nil, :school_id => @school.id)
        @subject.reload
        @subject.name.should eq(@subject.name)
      end

      it "re-renders the edit method" do
        put :update, id: @subject, subject: FactoryGirl.attributes_for(:subject, name: nil, :school_id => @school.id)
        response.should render_template :edit
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @subject = FactoryGirl.create(:subject, :school_id => @school.id)
    end

    it "deletes the subject" do
      expect{
        delete :destroy, id: @subject
      }.to change(Subject,:count).by(-1)
    end

    it "redirects to subjects#index" do
      delete :destroy, id: @subject
      response.should redirect_to subjects_url
    end
  end
end
