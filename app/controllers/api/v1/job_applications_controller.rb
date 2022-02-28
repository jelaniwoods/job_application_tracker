class Api::V1::JobApplicationsController < Api::V1::GraphitiController
  def index
    job_applications = JobApplicationResource.all(params)
    respond_with(job_applications)
  end

  def show
    job_application = JobApplicationResource.find(params)
    respond_with(job_application)
  end

  def create
    job_application = JobApplicationResource.build(params)

    if job_application.save
      render jsonapi: job_application, status: :created
    else
      render jsonapi_errors: job_application
    end
  end

  def update
    job_application = JobApplicationResource.find(params)

    if job_application.update_attributes
      render jsonapi: job_application
    else
      render jsonapi_errors: job_application
    end
  end

  def destroy
    job_application = JobApplicationResource.find(params)

    if job_application.destroy
      render jsonapi: { meta: {} }, status: :ok
    else
      render jsonapi_errors: job_application
    end
  end
end
