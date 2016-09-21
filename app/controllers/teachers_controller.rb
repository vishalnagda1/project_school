class TeachersController < ApplicationController

  def index
    @teachers = Teacher.all   #It'll return all the available Teacher.
  end

  def index_by_school_id
    @school = School.find(params[:format])

    if @school
      @teachers = @school.teachers
    end
  end

  def show
    @teacher = Teacher.find(params[:id])  #it'll show a requested Teacher based on Teacher ID.
  end

  def new
    @teacher = Teacher.new  # it'll create a new instance variable called @teacher.
  end

  def edit
    @teacher = Teacher.find(params[:id])  # it'll update the teacher.
  end

  def create
    # render plain: params[:teacher].inspect
    # p teacher_params
    teacher_params=(params.require(:teacher).permit(:name, :gender, :phone, :school_id)).merge(:classroom_ids=>params[:teacher][:classroom_ids],:subject_ids=>params[:teacher][:subject_ids])
    @teacher = Teacher.new(teacher_params)   # it'll create a new teacher with all the params.

    if @teacher.save   #it'll save the newly created teacher & returns the boolean values.
      redirect_to @teacher
    else
      render 'new'  # this method is used so that the @teacher object is passed back to the new template when it is rendered
    end
  end

  def update
    @teacher = Teacher.find(params[:id])
    teacher_params=(params.require(:teacher).permit(:name, :gender, :phone, :school_id)).merge(:classroom_ids=>params[:teacher][:classroom_ids],:subject_ids=>params[:teacher][:subject_ids])
    if @teacher.update(teacher_params)  # it'll update teacher and return boolean values.
      redirect_to @teacher
    else
      render 'edit'
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy   # it'll delete the requested teacher, based on Teacher ID

    redirect_to teachers_path
  end

  private
  # This fuction is for whitelisting the required parameters.
  def teacher_params
    params.require(:teacher).permit(:name, :gender, :phone, :school_id)
  end

end
