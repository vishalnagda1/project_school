class ClassroomsController < ApplicationController

  def index
    @classrooms = Classroom.all   #It'll return all the available Classroom.
  end

  def index_by_school_id
    # render plain: params[:classroom].inspect
    @school = School.find(params[:format])
    if @school
      @classrooms = @school.classrooms
    end
  end

  def show
    @classroom = Classroom.find(params[:id])  #it'll show a requested Classroom based on Classroom ID.
  end

  def new
    @classroom = Classroom.new  # it'll create a new instance variable called @classroom.
  end

  def edit
    @classroom = Classroom.find(params[:id])  # it'll update the Classroom.
  end

  def create
    # render plain: params[:classroom].inspect
    classroom_params=(params.require(:classroom).permit(:name, :no_of_students, :school_id)).merge(:subject_ids=>params[:classroom][:subject_ids])
    @classroom = Classroom.new(classroom_params)   # it'll create a new classroom with all the params.

    if @classroom.save   #it'll save the newly created classroom & returns the boolean values.
      redirect_to @classroom
    else
      render 'new'  # this method is used so that the @classroom object is passed back to the new template when it is rendered
    end
  end

  def update
    @classroom = Classroom.find(params[:id])
    classroom_params=(params.require(:classroom).permit(:name, :no_of_students, :school_id)).merge(:subject_ids=>params[:classroom][:subject_ids])
    if @classroom.update(classroom_params)  # it'll update Classroom and return boolean values.
      redirect_to @classroom
    else
      render 'edit'
    end
  end

  def destroy
    @classroom = Classroom.find(params[:id])

    begin
      Classroom.transaction do
        Classroom.find(@classroom.id).students.destroy_all
      end
    end

    @classroom.destroy   # it'll delete the requested Classroom, based on Classroom ID

    redirect_to classrooms_path
  end
end
