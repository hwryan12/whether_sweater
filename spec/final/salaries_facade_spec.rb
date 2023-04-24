require 'rails_helper'

RSpec.describe SalariesFacade, type: :facade do
  context 'instance methods' do
    describe '#get_tech_salaries' do
      let!(:city) { 'Houston, TX' }
      it 'returns a tech salaries for a given city as serialzed JSON' do
        VCR.use_cassette('salaries_facade') do
          salaries = SalariesFacade.new.get_tech_salaries(city)
          
          expect(salaries).to be_a(Salary)
          expect(salaries.destination).to be_a(String)
          expect(salaries.summary).to be_a(String)
          expect(salaries.temperature).to be_a(String)
          expect(salaries.jobs).to be_an(Array)
          
          salaries.jobs.each do |job|
            expect(job[:title]).to be_a(String)
            expect(job[:min]).to be_a(String)
            expect(job[:max]).to be_a(String)
          end
        end
      end
    end
  end
end