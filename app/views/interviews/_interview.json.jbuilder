json.extract! interview, :id, :starts_on, :round, :completed,
              :job_application_id, :created_at, :updated_at
json.url interview_url(interview, format: :json)
