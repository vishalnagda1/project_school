class TeachersController < ApplicationController

  def index
    @teachers = Teacher.all   #It'll return all the available Teacher.
    render :json => @teachers, status: :ok
  end

  def index_by_school_id # Only display teachers of particular school.
    @school = School.find(params[:format])

    if @school
      params[:format]=@school.id
      @teachers = @school.teachers
      render :json => @teachers, status: :ok
    end
  end

  def show
    begin
      @teacher = Teacher.find(params[:id])  #it'll show a requested Teacher based on Teacher ID.
      render :json => @teacher, status: :ok
    rescue => e
      p e
      render :json => { "error" => e.message}, :status => :unprocessable_entity
    end
  end

  def new
    @teacher = Teacher.new  # it'll create a new instance variable called @teacher.
  end

  def edit
    @teacher = Teacher.find(params[:id])  # it'll update the teacher.
  end

  def create
    begin
      teacher_params=(params.require(:teacher).permit(:name, :gender, :phone, :school_id)).merge(:classroom_ids=>params[:teacher][:classroom_ids],:subject_ids=>params[:teacher][:subject_ids])
      @teacher = Teacher.new(teacher_params)   # it'll create a new teacher with all the params.

      if @teacher.save   #it'll save the newly created teacher & returns the boolean values.
        render :json => @teacher, status: :ok
        # redirect_to @teacher
      end
    rescue => e
      p e
      p e.backtrace
      render :json => { "error" => e.message}, :status => :unprocessable_entity
        # params[:format] = @teacher.school_id
        # render 'new'  # this method is used so that the @teacher object is passed back to the new template when it is rendered
    end
  end

  def update
    begin
      @teacher = Teacher.find(params[:id])
      teacher_params=(params.require(:teacher).permit(:name, :gender, :phone, :school_id)).merge(:classroom_ids=>params[:teacher][:classroom_ids],:subject_ids=>params[:teacher][:subject_ids])
      if @teacher.update(teacher_params)  # it'll update teacher and return boolean values.
        # redirect_to @teacher
        render :json => @teacher, status: :ok
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
      @teacher = Teacher.find(params[:id])
      if @teacher.destroy   # it'll delete the requested teacher, based on Teacher ID
        render :json => {}, status: :ok
      end
    rescue => e
      p e
      p e.backtrace
      render :json => { "error" => e.message}, :status => :unprocessable_entity
    end
    # redirect_to teachers_path
  end
end
