class StudentsController < ApplicationController

  def index
    @students = Student.all   #It'll return all the available Student.
  end

  def show
    @student = Student.find(params[:id])  #it'll show a requested Student based on Student ID.
  end

  def new
    @student = Student.new  # it'll create a new instance variable called @student.
  end

  def edit
    @student = Student.find(params[:id])  # it'll update the student.
  end

  def create
    # render plain: params[:student].inspect
    @student = Student.new(student_params)   # it'll create a new student with all the params.

    if @student.save   #it'll save the newly created student & returns the boolean values.
      redirect_to @student
    else
      render 'new'  # this method is used so that the @student object is passed back to the new template when it is rendered
    end
  end

  def update
    @student = Student.find(params[:id])

    if @student.update(student_params)  # it'll update student and return boolean values.
      redirect_to @student
    else
      render 'edit'
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy   # it'll delete the requested student, based on Student ID

    redirect_to students_path
  end

  private
  # This fuction is for whitelisting the required parameters.
  def student_params
    params.require(:student).permit(:name, :father_name, :mother_name, :address, :city, :state, :zipcode, :phone)
  end
  
end
