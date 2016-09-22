require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  describe "GET #index" do
    it "populates an list of schools" do
      school = FactoryGirl.create(:school)
      get :index
      assigns(:schools).should eq([school])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested school to @school" do
      school = FactoryGirl.create(:school)
      get :show, id: school
      assigns(:school).should eq(school)
    end

    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:school)
      response.should render_template :show
    end
  end
  context "GET new" do
    it "should assign a new school to @school" do
      get :new
      expect(assigns(:school)).to be_a_new(School)
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new school" do
        expect{
          post :create, school: FactoryGirl.attributes_for(:school)
        }.to change(School,:count).by(1)
      end

      it "redirects to the new school" do
        post :create, school: FactoryGirl.attributes_for(:school)
        response.should redirect_to School.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new school" do
        expect{
          post :create, school: FactoryGirl.attributes_for(:school, :name=>nil)
        }.to_not change(School,:count)
      end

      it "re-renders the new method" do
        post :create, school: FactoryGirl.attributes_for(:school, :name=>nil)
        response.should render_template :new
      end
    end
  end
  describe 'PUT update' do
    before :each do
      @school = FactoryGirl.create(:school, name: "DummyName")
    end

    context "valid attributes" do
      it "located the requested @school" do
        put :update, id: @school, school: FactoryGirl.attributes_for(:school)
        assigns(:school).should eq(@school)
      end

      it "changes @school's attributes" do
        put :update, id: @school, school: FactoryGirl.attributes_for(:school, name: "Dummy")
        @school.reload
        @school.name.should eq("Dummy")
      end

      it "redirects to the updated school" do
        put :update, id: @school, school: FactoryGirl.attributes_for(:school)
        response.should redirect_to @school
      end
    end

    context "invalid attributes" do
      it "locates the requested @school" do
        put :update, id: @school, school: FactoryGirl.attributes_for(:school, name: nil)
        assigns(:school).should eq(@school)
      end

      it "does not change @school's attributes" do
        put :update, id: @school,
            school: FactoryGirl.attributes_for(:school, name: nil)
        @school.reload
        @school.name.should eq(@school.name)
      end

      it "re-renders the edit method" do
        put :update, id: @school, school: FactoryGirl.attributes_for(:school, name: nil)
        response.should render_template :edit
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @school = FactoryGirl.create(:school)
    end

    it "deletes the school" do
      expect{
        delete :destroy, id: @school
      }.to change(School,:count).by(-1)
    end

    it "redirects to schools#index" do
      delete :destroy, id: @school
      response.should redirect_to schools_url
    end
  end
end
