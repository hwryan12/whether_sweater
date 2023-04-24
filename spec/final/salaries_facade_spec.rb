require 'rails_helper'

RSpec.describe SalariesFacade, type: :facade do
  context 'instance methods' do
    describe '#get_tech_salaries' do
      let!(:city) { 'Denver, CO' }
      it 'returns a tech salaries for a given city as serialzed JSON' do
        VCR.use_cassette('salaries_facade') do
          salaries = SalariesFacade.new.get_tech_salaries(city)
          binding.pry
          expect(salaries).to be_a(Hash)
        end
      end
    end
  end
end