class SchoolsController < ApplicationController

  def index
    @schools = School.all   #It'll return all the available School.
    render :json => @schools, :status => :ok
  end

  def show
    begin
      @school = School.find(params[:id])  #it'll show a requested School based on School ID.
      render :json => @school, :status => :ok
    rescue => e
      p e
      render :json => { "error" => e.message}, :status => :unprocessable_entity
    end
  end

  def new
    @school = School.new  # it'll create a new instance variable called @school.
  end

  def edit
    @school = School.find(params[:id])  # it'll update the school.
  end

  def create
    begin
      @school = School.new(school_params)   # it'll create a new school with all the params.
      if @school.save   #it'll save the newly created school & returns the boolean values.
        # redirect_to @school
        render :json => @school, :status => :ok
      end
    rescue => e
      p e
      p e.backtrace
      render :json => { "error" => e.message}, :status => :unprocessable_entity
      # render 'new'  # this method is used so that the @school object is passed back to the new template when it is rendered
    end
  end

  def update
    begin
      @school = School.find(params[:id])
      if @school.update(school_params)  # it'll update school and return boolean values.
        # redirect_to @school
        render :json => @school, :status => :ok
      end
    rescue => e
      p e
      p e.backtrace
      render :json => { "error" => e.message}, :status => :unprocessable_entity
      # render 'edit'
    end
  end

  def destroy
    begin
      @school = School.find(params[:id])
      begin
        School.transaction do # Before destroying school it'll destroy all the associated tables with it.
          School.find(@school.id).students.destroy_all
          School.find(@school.id).teachers.destroy_all
          School.find(@school.id).classrooms.destroy_all
          School.find(@school.id).subjects.destroy_all
        end
      end

      if @school.destroy   # it'll delete the requested school, based on School ID
        render :json => {}, :status => :ok
      end
    rescue => e
      p e
      p e.backtrace
      render :json => { "error" => e.message}, :status => :unprocessable_entity
    end
    # redirect_to schools_path
  end

  private
  # This fuction is for whitelisting the required parameters.
  def school_params
    params.require(:school).permit(:name, :address, :city, :state, :zipcode, :phone)
  end
end