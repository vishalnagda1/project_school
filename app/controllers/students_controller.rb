class StudentsController < ApplicationController

  def index
    @students = Student.all   #It'll return all the available Student.
  end

  def index_by_classroom_id # Only display students of particular classroom.
    @classroom = Classroom.find(params[:format])

    if @classroom
      params[:format] = @classroom.school_id
      @students = @classroom.students
    end
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
    student_params=(params.require(:student).permit(:name, :father_name, :mother_name, :address, :city, :state, :zipcode, :phone, :classroom_id, :school_id)).merge(:subject_ids=>params[:student][:subject_ids])
    @student = Student.new(student_params)   # it'll create a new student with all the params.
    if @student.save   #it'll save the newly created student & returns the boolean values.
      redirect_to @student
    else
      render 'new'  # this method is used so that the @student object is passed back to the new template when it is rendered
    end
  end

  def update
    @student = Student.find(params[:id])
    student_params=(params.require(:student).permit(:name, :father_name, :mother_name, :address, :city, :state, :zipcode, :phone, :classroom_id, :school_id)).merge(:subject_ids=>params[:student][:subject_ids])
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
end
