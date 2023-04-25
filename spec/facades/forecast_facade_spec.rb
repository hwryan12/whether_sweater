require 'rails_helper'

RSpec.describe ForecastFacade, type: :facade do
  context 'instance methods' do
    describe '#get_forecast' do
      let!(:location) { 'Denver, CO' }

      it 'returns a forecast object' do
        VCR.use_cassette('forecast_facade') do
          forecast = ForecastFacade.new.get_forecast(location)
         
          expect(forecast).to be_a(Forecast)
          expect(forecast.current_weather).to be_a(Hash)
          expect(forecast.current_weather[:last_updated]).to be_a(String)
          expect(forecast.current_weather[:temperature]).to be_a(Float)
          expect(forecast.current_weather[:feels_like]).to be_a(Float)
          expect(forecast.current_weather[:humidity]).to be_a(Integer)
          expect(forecast.current_weather[:uvi]).to be_a(Float)
          expect(forecast.current_weather[:visibility]).to be_a(Float)
          expect(forecast.current_weather[:condition]).to be_a(String)
          expect(forecast.current_weather[:icon]).to be_a(String)

          expect(forecast.daily_weather).to be_an(Array)
          expect(forecast.daily_weather.count).to eq(5)
          forecast.daily_weather.each do |day|
            expect(day[:date]).to be_a(String)
            expect(day[:sunrise]).to be_a(String)
            expect(day[:sunset]).to be_a(String)
            expect(day[:max_temp]).to be_a(Float)
            expect(day[:min_temp]).to be_a(Float)
            expect(day[:condition]).to be_a(String)
            expect(day[:icon]).to be_a(String)
          end
          
          expect(forecast.hourly_weather).to be_an(Array)
          expect(forecast.hourly_weather.count).to eq(24)
          forecast.hourly_weather.each do |hour|
            expect(hour[:time]).to be_a(String)
            expect(hour[:temperature]).to be_a(Float)
            expect(hour[:conditions]).to be_a(String)
            expect(hour[:icon]).to be_a(String)
          end
        end
      end
    end
  end
end