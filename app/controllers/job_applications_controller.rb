class JobApplicationsController < ApplicationController
  before_action :current_user_must_be_job_application_user,
                only: %i[edit update destroy]

  before_action :set_job_application, only: %i[show edit update destroy]

  def index
    @q = current_user.job_applications.ransack(params[:q])
    @job_applications = @q.result(distinct: true).includes(:user, :company,
                                                           :interviews).page(params[:page]).per(10)
  end

  def show
    @interview = Interview.new
  end

  def new
    @job_application = JobApplication.new
  end

  def edit; end

  def create
    @job_application = JobApplication.new(job_application_params)

    if @job_application.save
      message = "JobApplication was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @job_application, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @job_application.update(job_application_params)
      redirect_to @job_application,
                  notice: "Job application was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @job_application.destroy
    message = "JobApplication was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to job_applications_url, notice: message
    end
  end

  private

  def current_user_must_be_job_application_user
    set_job_application
    unless current_user == @job_application.user
      redirect_back fallback_location: root_path,
                    alert: "You are not authorized for that."
    end
  end

  def set_job_application
    @job_application = JobApplication.find(params[:id])
  end

  def job_application_params
    params.require(:job_application).permit(:title, :due_on, :status,
                                            :user_id, :company_id)
  end
end
