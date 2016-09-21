class ClassroomsController < ApplicationController

  def index
    @classrooms = Classroom.all   #It'll return all the available Classroom.
  end

  def school_class_index
    # render plain: params[:classroom].inspect
    p params
    @school = School.find(params[:format])
    p @school
    if @school
      @classrooms = @school.classrooms
      p @classrooms
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
    @classroom = Classroom.new(classroom_params)   # it'll create a new classroom with all the params.

    if @classroom.save   #it'll save the newly created classroom & returns the boolean values.
      redirect_to @classroom
    else
      render 'new'  # this method is used so that the @classroom object is passed back to the new template when it is rendered
    end
  end

  def update
    @classroom = Classroom.find(params[:id])

    if @classroom.update(classroom_params)  # it'll update Classroom and return boolean values.
      redirect_to @classroom
    else
      render 'edit'
    end
  end

  def destroy
    @classroom = Classroom.find(params[:id])
    @classroom.destroy   # it'll delete the requested Classroom, based on Classroom ID

    redirect_to classrooms_path
  end

  private
  # This fuction is for whitelisting the required parameters.
  def classroom_params
    params.require(:classroom).permit(:name, :no_of_students, :school_id)
  end

end
