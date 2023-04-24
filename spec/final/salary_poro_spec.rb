require  'rails_helper'

RSpec.describe  Salary do
  let!(:location) do
    {
      salaries: 
      [
        job:
        {
          title:  "Data Analyst"
        },
        salary_percentiles:
        {
          percentile_25:  5000.123456,
          percentile_75:  6000.123456
        }
      ],
      [
        job:
        {
          title:  "Data Scientist"
        },
        salary_percentiles:
        {
          percentile_25:  500.123456,
          percentile_75:  600.123456
        }
      ],
      [
        job:
        {
          title:  "Mobile Developer"
        },
        salary_percentiles:
        {
          percentile_25:  50.123456,
          percentile_75:  60.123456
        }
      ],
      [
        job:
        {
          title:  "QA Engineer"
        },
        salary_percentiles:
        {
          percentile_25:  5.123456,
          percentile_75:  6.123456
        }
      ]
    }
  end
  let!(:weather) do
    {
      location:
      {
        name:  "Denver"
      },
      current:
      {
        condition:
        {
          text:  "Partly cloudy"
        },
        temp_f:  65.0
      }
    }
  end

  describe  'instantiation' do
    let!(:salary) { Salary.new(location, weather) }
    it 'exists' do
      expect(salary).to be_a(Salary)
      expect(salary.destination).to eq('Denver')
      expect(salary.summary).to eq('Partly cloudy')
      expect(salary.temperature).to eq("65 F")
      expect(salary.jobs).to be_a(Array)
      expect(salary.jobs.count).to eq(4)
      expect(salary.jobs.first.title).to eq('Data Analyst')
      expect(salary.jobs.first.min).to eq("$5,000.12")
      expect(salary.jobs.first.max).to eq("$6,000.12")
      salary.jobs.each do |job|
        expect(job).to be_a(Hash)
        expect(job[:title]).to be_a(String)
        expect(job[:min]).to be_a(String)
        expect(job[:max]).to be_a(String)
      end
    end
  end
end