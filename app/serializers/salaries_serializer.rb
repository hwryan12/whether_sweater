class SalariesSerializer
  def initialize(data)
    @data = data
  end

  def serialize_salaries
    # binding.pry
    if @data.nil?
      { error: 'No data found' }
    else
      {
        data: {
          id: nil,
          type: 'salaries',
          attributes:
          {
            destination: @data.destination,
            forecast: {
              summary: @data.summary,
              temperature: @data.temperature
            },
            salaries: @data.jobs.map do |job|
            {
              title: job[:title],
              min: job[:min],
              max: job[:max]
            }
          end
          }
        }
      }
    end
  end
end