require 'rails_helper'

RSpec.describe SalariesFacade, type: :facade do
  context 'instance methods' do
    describe '#get_tech_salaries' do
      let!(:city) { 'Houston, TX' }
      it 'returns a tech salaries for a given city as serialzed JSON' do
        VCR.use_cassette('salaries_facade') do
          salaries = SalariesFacade.new.get_tech_salaries(city)
          binding.pry
          expect(salaries).to be_a(Hash)
          expect(salaries[:data]).to be_a(Hash)
          expect(salaries[:data][:id]).to be_nil
          expect(salaries[:data][:type]).to eq('salaries')
          expect(salaries[:data][:attributes]).to be_a(Hash)
          expect(salaries[:data][:attributes][:destination]).to be_a(String)
          expect(salaries[:data][:attributes][:forecast]).to be_a(Hash)
          expect(salaries[:data][:attributes][:forecast][:summary]).to be_a(String)
          expect(salaries[:data][:attributes][:forecast][:temperature]).to be_a(Float)
          expect(salaries[:data][:attributes][:salaries]).to be_an(Array)

          salaries[:data][:attributes][:salaries].each do |salary|
            expect(salary).to be_a(Hash)
            expect(salary[:title]).to be_a(String)
            expect(salary[:min]).to be_a(Float)
            expect(salary[:max]).to be_a(Float)
          end
        end
      end
    end
  end
end