class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[show edit update destroy]

  def index
    @q = Interview.ransack(params[:q])
    @interviews = @q.result(distinct: true).includes(:job_application,
                                                     :applicant, :company).page(params[:page]).per(10)
  end

  def show; end

  def new
    @interview = Interview.new
  end

  def edit; end

  def create
    @interview = Interview.new(interview_params)

    if @interview.save
      message = "Interview was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @interview, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @interview.update(interview_params)
      redirect_to @interview, notice: "Interview was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @interview.destroy
    message = "Interview was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to interviews_url, notice: message
    end
  end

  private

  def set_interview
    @interview = Interview.find(params[:id])
  end

  def interview_params
    params.require(:interview).permit(:starts_on, :round, :completed,
                                      :job_application_id)
  end
end
