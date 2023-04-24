class Salary

  def initialize(location, weather)
    binding.pry
    @destination = weather[:location][:name]
    @summary = weather[:current][:condition][:text]
    @temperature = weather[:current][:temp_f]
    @jobs = filtered_jobs(location)
  end

  private

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
        min: job[:salary_percentiles][:percentile_25],
        max: job[:salary_percentiles][:percentile_75]
      }
    end
  end
end