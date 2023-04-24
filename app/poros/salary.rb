class Salary
  attr_reader :destination, 
              :summary, 
              :temperature, 
              :jobs

  def initialize(location, weather)
    @destination = weather[:location][:name]
    @summary = weather[:current][:condition][:text]
    @temperature = formatted_temperature(weather[:current][:temp_f])
    @jobs = tech_jobs(location)
  end

  private

  def formatted_temperature(temperature)
    "#{temperature.round} F"
  end

  def formatted_salary(salary)
    formatted_salary = format('%.2f', salary).gsub(/\d(?=(\d{3})+\.)/, '\0,')
    "$#{formatted_salary}"
  end

  def filtered_jobs(location)
    job_titles = [
      "Data Analyst",
      "Data Scientist",
      "Mobile Developer",
      "QA Engineer",
      "Software Engineer",
      "Systems Administrator",
      "Web Developer"
    ]

    location[:salaries].select do |salary|
      job_titles.include?(salary[:job][:title])
    end
  end

  def tech_jobs(location)
    filtered_jobs(location).map do |job|
      { 
        title: job[:job][:title],
        min: formatted_salary(job[:salary_percentiles][:percentile_25]),
        max: formatted_salary(job[:salary_percentiles][:percentile_75])
      }
    end
  end
end