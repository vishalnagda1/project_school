class SubjectsController < ApplicationController

  def index
    @subjects = Subject.all   #It'll return all the available Subject.
    render :json => @subjects, status: :ok
  end

  def index_by_school_id # Only display subjects of particular school.
    @school = School.find(params[:format])

    if @school
      params[:format] = @school.id
      @subjects = @school.subjects
      render :json => @subjects, status: :ok
    end
  end

  def show
    begin
      @subject = Subject.find(params[:id])  #it'll show a requested Subject based on Subject ID.
      render :json => @subject, status: :ok
    rescue => e
      p e
      render :json => { "error" => e.message}, :status => :unprocessable_entity
    end
  end

  def new
    @subject = Subject.new  # it'll create a new instance variable called @subject.
  end

  def edit
    @subject = Subject.find(params[:id])  # it'll update the subject.
  end

  def create
    begin
      @subject = Subject.new(subject_params)   # it'll create a new subject with all the params.
        if @subject.save   # it'll save the newly created subject & returns the boolean values.
          # redirect_to @subject
          render :json => @subject, status: :ok
        end
    rescue => e
      p e
      p e.backtrace
      render :json => { "error" => e.message}, :status => :unprocessable_entity
      # render 'new'  # this method is used so that the @subject object is passed back to the new template when it is rendered
    end
  end

  def update
    begin
      @subject = Subject.find(params[:id])
      if @subject.update(subject_params)  # it'll update subject and return boolean values.
        # redirect_to @subject
        render :json => @subject, status: :ok
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
      @subject = Subject.find(params[:id])
      if @subject.destroy   # it'll delete the requested subject, based on Subject ID
        render :json => {}, status: :ok
      end
    rescue => e
      p e
      p e.backtrace
      render :json => { "error" => e.message}, :status => :unprocessable_entity
    end
    # redirect_to subjects_path
  end

  private
  # This fuction is for whitelisting the required parameters.
  def subject_params
    params.require(:subject).permit(:name, :school_id)
  end

end
