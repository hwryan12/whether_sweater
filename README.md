# Weather, Sweater? 

## Table of Contents

- [Technical Details](#technical-details)
- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
  - [Forecast Endpoint](#forecast-endpoint)
  - [User Registration Endpoint](#user-registration-endpoint)
  - [Login Endpoint](#login-endpoint)
  - [Road Trip Endpoint](#road-trip-endpoint)
- [Database and Schema](#database-and-schema)
- [Learning Goals](#learning-goals)
- [Contributor(s)](#contributors)

## Technical Details
Weather, Sweater? is a Ruby on Rails API that aggregates data from multiple external APIs and exposes an API endpoint for the front-end application. Here are some of the key technologies used for the Back End service:

- **`Ruby on Rails`**: This application is built with Ruby on Rails, a powerful web framework for easy web development with APIs and data storage options.
- **`PostgreSQL`**: It uses PostgreSQL for robust web application data storage and management.
- **`External APIs`**: This application consumes external APIs from `MapQuest Geocoding` and `WeatherAPI` to provide route planning and weather information.
- **`RSpec`**: RSpec is used for the test suite to ensure the API is functioning correctly and providing the expected results.
- **`VCR`**: VCR is used to record and replay HTTP interactions to enable fast and deterministic tests.

## Getting Started
Weather, Sweater? is a Ruby on Rails API that requires you to clone and set up the repository. You will need to ensure all required gems are installed and that environment variables are properly configured in order to run the app locally.

To get started, clone this repo down and install all gems by running:
```
bundle install
```
Next, run this command to make sure the database is properly created and migrated:
```
rails db:{create,migrate}
```
If you'd like to see the testing for this application, just run this:
```
bundle exec rspec spec
```

## Endpoints
### Forecast Endpoint
Example request:
`GET /api/v0/forecast?location=:location`

*Headers*:
```
Content-Type: application/json 
Accept: application/json
```

Example response (using Houston, TX as the example location):
```bash
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2023-04-26 07:15",
        "temperature": 68.0,
        "feels_like": 68.0,
        "humidity": 94,
        "uvi": 4.0,
        "visibility": 2.0,
        "condition": "Mist",
        "icon": "//cdn.weatherapi.com/weather/64x64/day/143.png"
      },
      "daily_weather": [
        {
            "date": "2023-04-26",
            "sunrise": "06:44 AM",
            "sunset": "07:55 PM",
            "max_temp": 80.1,
            "min_temp": 65.5,
            "condition": "Patchy rain possible",
            "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png"
        },
        {...} etc
      ],
      "hourly_weather": [
        {
            "time": "00:00",
            "temperature": 67.3,
            "conditions": "Patchy light rain with thunder",
            "icon": "//cdn.weatherapi.com/weather/64x64/night/386.png"
        },
        {...} etc
      ]
    }
  }
}
```
*Note*: `daily_weather` should return an array of 5 days and `hourly_weather` should return an array of 24 hours

### User Registration Endpoint
Example request:
`POST /api/v0/users`


```bash
Content-Type: application/json 
Accept: application/json

{
  "email": "sweaterweather@example.com",
  "password": "12345",
  "password_confirmation": "12345"
}
```
Example response:
```bash
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "sweaterweather@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```

### Login Endpoint
Example request:
`POST /api/v0/sessions`


```bash
Content-Type: application/json 
Accept: application/json

{
  "email": "sweaterweather@example.com",
  "password": "12345",
}
```
Example response:
```bash
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "sweaterweather@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```

### Road Trip Endpoint
Example request:
`POST /api/v1/road_trip`

```bash
Content-Type: application/json 
Accept: application/json

{
  "origin": "Denver, CO",
  "destination": "Pueblo, CO",
  "api_key": "your_api_key_here"
}
```
Example response:
```bash
{
  "data": {
    "id": null,
    "type": "road_trip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Pueblo, CO",
      "travel_time": "01:44:22",
      "weather_at_eta": {
        "temperature": 301.15,
        "conditions": "clear sky"
      }
    }
  }
}
```
## Database and Schema

The only database table needed in the schema for this project is for `users`. Besides saving user information, this API app only consumes and exposes data from external APIs.

*`Users`*:
```
create_table "users", force: :cascade do |t|
  t.string "email"
  t.string "password_digest"
  t.string "api_key"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end
```
## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).
## Contributor(s)
- Harrison Ryan