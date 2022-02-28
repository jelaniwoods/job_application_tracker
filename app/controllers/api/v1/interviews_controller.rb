class Api::V1::InterviewsController < Api::V1::GraphitiController
  def index
    interviews = InterviewResource.all(params)
    respond_with(interviews)
  end

  def show
    interview = InterviewResource.find(params)
    respond_with(interview)
  end

  def create
    interview = InterviewResource.build(params)

    if interview.save
      render jsonapi: interview, status: :created
    else
      render jsonapi_errors: interview
    end
  end

  def update
    interview = InterviewResource.find(params)

    if interview.update_attributes
      render jsonapi: interview
    else
      render jsonapi_errors: interview
    end
  end

  def destroy
    interview = InterviewResource.find(params)

    if interview.destroy
      render jsonapi: { meta: {} }, status: :ok
    else
      render jsonapi_errors: interview
    end
  end
end
