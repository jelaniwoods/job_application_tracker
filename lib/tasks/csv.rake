namespace :csv do
  desc "TODO"
  task users: :environment do
    users_path = "users.csv"

    # users_file = File.open(users_path, File::RDWR)
    users_headers = "id,email,password"
    lines = [users_headers]
    50.times do |n|
      line = "#{n+1},#{Faker::Name.first_name.downcase}@example.com,password"
      lines << line
    end
    new_content = lines.join("\n")
    # users_file.seek(0)
    # users_file.write(new_content)
    File.open(users_path, "w") do |f|     
      f.write(new_content)   
    end
  end

  desc "TODO"
  task add_users: :environment do
    require "csv"
    Interview.destroy_all
    JobApplication.destroy_all
    User.destroy_all
    csv_text = File.read("users.csv")
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      h = {
        id: row["id"],
        email: row["email"],
        password: row["password"]
      }
      User.create(h)
    end
    p "Users #{User.count}"
  end

  desc "TODO"
  task add_companies: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "companies.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      h = {
        id: row["id"],
        name: row["name"],
        sector: row["sector"]
      }
      Company.find_or_create_by(h)
    end
    p "Companies #{Company.count}"
  end

  desc "TODO"
  task applications: :environment do


    application_path = "applications.csv"

    # application_file = File.open(application_path, File::RDWR)
    application_headers = "id,title,due_on,submitted,user_id,company_id"
    lines = [application_headers]
    num = 1
    User.all.each do |user|
      rand(5..30).times do |n|
        due_on = Faker::Date.between(from: 1.month.ago, to: 2.months.from_now)
        if due_on <= Date.today
          submitted = true
        else
          n = rand(1..10)
          if n.even?
            submitted = false
          else
            submitted = true
          end
        end
        line = "#{num},#{Faker::Job.title},#{due_on.to_s},#{submitted},#{user.id},#{Company.all.ids.sample}"
        lines << line
        num += 1
      end
    end
    new_content = lines.join("\n")
    # application_file.seek(0)
    # application_file.write(new_content)
    File.open(application_path, "w") do |f|     
      f.write(new_content)   
    end
  end

  task add_applications: :environment do
    require "csv"

    csv_text = File.read("job_applications.csv")
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      date = rand(7..21).days.from_now
      h = {
        id: row["id"],
        title: row["title"],
        due_on: date,
        user_id: row["user_id"],
        company_id: row["company_id"],
        status: row["status"].downcase
      }
      j = JobApplication.find_or_create_by(h)
      p j.errors.full_messages
    end
    p "applications #{JobApplication.count}"
  end

  desc "TODO"
  task interviews: :environment do

    interviews_path = "interviews.csv"

    # interviews_file = File.open(interviews_path, File::RDWR)
    interviews_headers = "id,round,starts_at,complete,application_id"
    lines = [interviews_headers]
    num = 1
    JobApplication.where(submitted: true).all.each_with_index do |application, n|
      rand(1..3).times do |i|
        app_id = application.id
        round = i + 1
        if round == 1
          starts_at = JobApplication.find(app_id).due_on + rand(3..6).days + rand(9..14).hours
        elsif round == 2
          starts_at = starts_at = JobApplication.find(app_id).due_on + rand(7..14).days + rand(9..14).hours
        else
          starts_at = starts_at = JobApplication.find(app_id).due_on + rand(15..18).days + rand(9..14).hours
        end

        if starts_at < Date.current
          complete = true
        else
          complete = false
        end
        line = "#{num},#{round},#{starts_at.to_s},#{complete},#{app_id}"
        lines << line
        num += 1
      end
    end
    new_content = lines.join("\n")
    File.open(interviews_path, "w") do |f|     
      f.write(new_content)   
    end
  end


  task add_interviews: :environment do
    require "csv"

    csv_text = File.read("interviews.csv")
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      h = {
        id: row["id"],
        round: row["round"],
        starts_on: DateTime.parse(row["starts_on"]),
        job_application_id: row["application_id"],
        completed: row["completed"]
      }
      Interview.find_or_create_by(h)
    end
    p "Interviews #{Interview.count}"
  end

  task fix_interviews: :environment do
    JobApplication.where(status: "Applied").all.each do |a|
      rand(1..3).times do |n|
        round = n + 1
        if round == 1
          starts_at = a.due_on + rand(3..6).days + rand(9..14).hours
        elsif round == 2
          starts_at = a.due_on + rand(7..14).days + rand(9..14).hours
        else
          starts_at = a.due_on + rand(15..18).days + rand(9..14).hours
        end
        c = starts_at < Date.current ? true : false

        a.interviews.create(round: round, starts_at: starts_at, completed: c)
      end
    end
  end
end
