json.extract! job_application, :id, :title, :due_on, :status, :user_id,
              :company_id, :created_at, :updated_at
json.url job_application_url(job_application, format: :json)
