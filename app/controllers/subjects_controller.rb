class SubjectsController < ApplicationController

  def index
    @subjects = Subject.all   #It'll return all the available Subject.
  end

  def show
    @subject = Subject.find(params[:id])  #it'll show a requested Subject based on Subject ID.
  end

  def new
    @subject = Subject.new  # it'll create a new instance variable called @subject.
  end

  def edit
    @subject = Subject.find(params[:id])  # it'll update the subject.
  end

  def create
    # render plain: params[:subject].inspect
    @subject = Subject.new(subject_params)   # it'll create a new subject with all the params.

    if @subject.save   #it'll save the newly created subject & returns the boolean values.
      redirect_to @subject
    else
      render 'new'  # this method is used so that the @subject object is passed back to the new template when it is rendered
    end
  end

  def update
    @subject = Subject.find(params[:id])

    if @subject.update(subject_params)  # it'll update subject and return boolean values.
      redirect_to @subject
    else
      render 'edit'
    end
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy   # it'll delete the requested subject, based on Subject ID

    redirect_to subjects_path
  end

  private
  # This fuction is for whitelisting the required parameters.
  def subject_params
    params.require(:subject).permit(:name, :address, :city, :state, :zipcode, :phone)
  end

end
