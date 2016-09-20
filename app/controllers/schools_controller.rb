class SchoolsController < ApplicationController

  def index
    @schools = School.all   #It'll return all the available School.
  end

  def show
    @school = School.find(params[:id])  #it'll show a requested School based on School ID.
  end

  def new
    @school = School.new  # it'll create a new instance variable called @school.
  end

  def edit
    @school = School.find(params[:id])  # it'll update the school.
  end

  def create
    # render plain: params[:school].inspect
    @school = School.new(school_params)   # it'll create a new school with all the params.

    if @school.save   #it'll save the newly created school & returns the boolean values.
      redirect_to @school
    else
      render 'new'  # this method is used so that the @school object is passed back to the new template when it is rendered
    end
  end

  def update
    @school = School.find(params[:id])

    if @school.update(school_params)  # it'll update school and return boolean values.
      redirect_to @school
    else
      render 'edit'
    end
  end

  def destroy
    @school = School.find(params[:id])
    @school.destroy   # it'll delete the requested school, based on School ID

    redirect_to schools_path
  end

  private
  # This fuction is for whitelisting the required parameters.
  def school_params
    params.require(:school).permit(:name, :address, :city, :state, :zipcode, :phone)
  end
end